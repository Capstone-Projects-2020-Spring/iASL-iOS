// Copyright 2019 The TensorFlow Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit
import AVFoundation

// MARK: CameraFeedManagerDelegate Declaration
/// Delegate that manages the camera feed and how data is sent to our machine learning model.
protocol CameraFeedManagerDelegate: class {

	/**
	This method delivers the pixel buffer of the current frame seen by the device's camera.
	- Parameter pixelBuffer: A reference to a Core Video pixel buffer object to be infered. Basically the frame.
	*/
	func didOutput(pixelBuffer: CVPixelBuffer)

	/**
	This method initimates that the camera permissions have been denied.
	*/
	func presentCameraPermissionsDeniedAlert()

	/**
	This method initimates that there was an error in video configurtion.
	*/
	func presentVideoConfigurationErrorAlert()

	/**
	This method initimates that a session runtime error occured.
	*/
	func sessionRunTimeErrorOccured()

	/**
	This method initimates that the session was interrupted.
	- Parameter resumeManually: boolean value for whether the session can be resumed manually
	*/
	func sessionWasInterrupted(canResumeManually resumeManually: Bool)

	/**
	This method initimates that the session interruption has ended.
	*/
	func sessionInterruptionEnded()
    
}

/**
This enum holds the state of the camera initialization.
*/
enum CameraConfiguration {
	/// camera was initialized succesfully
	case success
	/// camera did not initialize successfully
	case failed
	/// user has denied iASL access to camera
	case permissionDenied
}

/**
This class manages all camera related functionality
*/
class CameraFeedManager: NSObject {
    var count = 0
    var tempOutput = ""
	// MARK: Camera Related Instance Variables
	/// An object that manages capture activity and coordinates the flow of data from input devices to capture outputs.
	private let session: AVCaptureSession = AVCaptureSession()
	
	/// The camera viewfinder.
	private let previewView: PreviewView
	
	/// An object that manages the execution of session tasks serially or concurrently on your iASL's main thread or on a background thread.
	private let sessionQueue = DispatchQueue(label: "sessionQueue")
	
	/// This enum holds the state of the camera initialization.
	private var cameraConfiguration: CameraConfiguration = .failed
	
	/// A capture output that records video and provides access to video frames for processing.
	private lazy var videoDataOutput = AVCaptureVideoDataOutput()
	
	/// Boolean to check whether the session is currently running.
	private var isSessionRunning = false

	// MARK: CameraFeedManagerDelegate
	/// Delegate that manages the camera feed and how data is sent to our machine learning model.
	weak var delegate: CameraFeedManagerDelegate?

	// MARK: Initializer
	/// Initializes the view with the camera viewfinder known as previewView.
	/// - Parameter previewView: The camera viewfinder object.
	init(previewView: PreviewView) {
		self.previewView = previewView
		super.init()

		// Initializes the session
		session.sessionPreset = .high
		self.previewView.session = session
		setPreviewViewOrientaion()
		self.previewView.previewLayer.videoGravity = .resizeAspectFill
		self.attemptToConfigureSession()
	}

	// MARK: Session Start and End methods

	/**
	This method starts an AVCaptureSession based on whether the camera configuration was successful.
	*/
	func checkCameraConfigurationAndStartSession() {
		sessionQueue.async {
			switch self.cameraConfiguration {
			case .success:
				self.addObservers()
				self.startSession()
			case .failed:
				DispatchQueue.main.async {
					self.delegate?.presentVideoConfigurationErrorAlert()
				}
			case .permissionDenied:
				DispatchQueue.main.async {
					self.delegate?.presentCameraPermissionsDeniedAlert()
				}
			}
		}
	}

	/**
	This method stops a running an AVCaptureSession.
	*/
	func stopSession() {
		self.removeObservers()
		sessionQueue.async {
			if self.session.isRunning {
				self.session.stopRunning()
				self.isSessionRunning = self.session.isRunning
			}
		}

	}

	/**
	This method resumes an interrupted AVCaptureSession.
	*/
	func resumeInterruptedSession(withCompletion completion: @escaping (Bool) -> Void) {

		sessionQueue.async {
			self.startSession()

			DispatchQueue.main.async {
				completion(self.isSessionRunning)
			}
		}
	}

	/**
	This method starts the AVCaptureSession
	**/
	private func startSession() {
		self.session.startRunning()
		self.isSessionRunning = self.session.isRunning
	}

	// MARK: Session Configuration Methods.
	/**
	This method requests for camera permissions and handles the configuration of the session and stores the result of configuration.
	*/
	private func attemptToConfigureSession() {
		switch AVCaptureDevice.authorizationStatus(for: .video) {
		case .authorized:
			self.cameraConfiguration = .success
		case .notDetermined:
			self.sessionQueue.suspend()
			self.requestCameraAccess(completion: { (_) in
				self.sessionQueue.resume()
			})
		case .denied:
			self.cameraConfiguration = .permissionDenied
		default:
			break
		}

		self.sessionQueue.async {
			self.configureSession()
		}
	}

	/**
	This method requests for camera permissions.
	*/
	private func requestCameraAccess(completion: @escaping (Bool) -> Void) {
		AVCaptureDevice.requestAccess(for: .video) { (granted) in
			if !granted {
				self.cameraConfiguration = .permissionDenied
			} else {
				self.cameraConfiguration = .success
			}
			completion(granted)
		}
	}

	/**
	This method handles all the steps to configure an AVCaptureSession.
	*/
	private func configureSession() {

		guard cameraConfiguration == .success else {
			return
		}
		session.beginConfiguration()

		// Tries to add an AVCaptureDeviceInput.
		guard addVideoDeviceInput() == true else {
			self.session.commitConfiguration()
			self.cameraConfiguration = .failed
			return
		}

		// Tries to add an AVCaptureVideoDataOutput.
		guard addVideoDataOutput() else {
			self.session.commitConfiguration()
			self.cameraConfiguration = .failed
			return
		}

		session.commitConfiguration()
		self.cameraConfiguration = .success
	}

	/**
	This method tries to an AVCaptureDeviceInput to the current AVCaptureSession.
	*/
	private func addVideoDeviceInput() -> Bool {

		/**Tries to get the default back camera.
		*/
		guard let camera  = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
			return false
		}

		do {
			let videoDeviceInput = try AVCaptureDeviceInput(device: camera)
			if session.canAddInput(videoDeviceInput) {
				session.addInput(videoDeviceInput)
				return true
			} else {
				return false
			}
		} catch {
			fatalError("Cannot create video device input")
		}
	}
	fileprivate func setPreviewViewOrientaion() {
		switch UIDevice.current.orientation {
		case .portrait:
			self.previewView.previewLayer.connection?.videoOrientation = .portrait
		case .landscapeLeft:
			self.previewView.previewLayer.connection?.videoOrientation = .landscapeRight
		case .landscapeRight:
			self.previewView.previewLayer.connection?.videoOrientation = .landscapeLeft
		case .portraitUpsideDown:
			self.previewView.previewLayer.connection?.videoOrientation = .portraitUpsideDown
		default:
			self.previewView.previewLayer.connection?.videoOrientation = .portrait
		}
	}
	fileprivate func setVideoOutputOrientaion() {
		switch UIDevice.current.orientation {
		case .portrait:
			videoDataOutput.connection(with: .video)?.videoOrientation = .portrait
		case .landscapeLeft:
			videoDataOutput.connection(with: .video)?.videoOrientation = .landscapeRight
		case .landscapeRight:
			videoDataOutput.connection(with: .video)?.videoOrientation = .landscapeLeft
		case .portraitUpsideDown:
			videoDataOutput.connection(with: .video)?.videoOrientation = .portraitUpsideDown
		default:
			videoDataOutput.connection(with: .video)?.videoOrientation = .portrait
		}
	}
	/**
	This method tries to an AVCaptureVideoDataOutput to the current AVCaptureSession.
	- Returns: returns `true` if the session can output video.
	*/
	private func addVideoDataOutput() -> Bool {

		let sampleBufferQueue = DispatchQueue(label: "sampleBufferQueue")
		videoDataOutput.setSampleBufferDelegate(self, queue: sampleBufferQueue)
		videoDataOutput.alwaysDiscardsLateVideoFrames = true
		videoDataOutput.videoSettings = [ String(kCVPixelBufferPixelFormatTypeKey): kCMPixelFormat_32BGRA]

		if session.canAddOutput(videoDataOutput) {
			session.addOutput(videoDataOutput)
//			videoDataOutput.connection(with: .video)?.videoOrientation = .landscapeLeft
			setVideoOutputOrientaion()
			return true
		}
		return false
	}

	// MARK: Notification Observer Handling
	/// Adds all of the observers for the camera controller.
	private func addObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(CameraFeedManager.sessionRuntimeErrorOccured(notification:)), name: NSNotification.Name.AVCaptureSessionRuntimeError, object: session)
		NotificationCenter.default.addObserver(self, selector: #selector(CameraFeedManager.sessionWasInterrupted(notification:)), name: NSNotification.Name.AVCaptureSessionWasInterrupted, object: session)
		NotificationCenter.default.addObserver(self, selector: #selector(CameraFeedManager.sessionInterruptionEnded), name: NSNotification.Name.AVCaptureSessionInterruptionEnded, object: session)
	}
	/// Removes all observers for the camera controller when we're done with them.
	private func removeObservers() {
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVCaptureSessionRuntimeError, object: session)
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVCaptureSessionWasInterrupted, object: session)
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVCaptureSessionInterruptionEnded, object: session)
	}

	// MARK: Notification Observers
	/// Called when the camera session was interrupted.
	/// - Parameter notification: Notification that is immediately called when the camera session is interrupted.
	@objc func sessionWasInterrupted(notification: Notification) {

		if let userInfoValue = notification.userInfo?[AVCaptureSessionInterruptionReasonKey] as AnyObject?,
			let reasonIntegerValue = userInfoValue.integerValue,
			let reason = AVCaptureSession.InterruptionReason(rawValue: reasonIntegerValue) {
			print("Capture session was interrupted with reason \(reason)")

			var canResumeManually = false
			if reason == .videoDeviceInUseByAnotherClient {
				canResumeManually = true
			} else if reason == .videoDeviceNotAvailableWithMultipleForegroundApps {
				canResumeManually = false
			}

			self.delegate?.sessionWasInterrupted(canResumeManually: canResumeManually)

		}
	}
	
	/// Called when the system is notified that the camera session was interupted
	/// - Parameter notification: Notification called when the session has been interupted.
	@objc func sessionInterruptionEnded(notification: Notification) {

		self.delegate?.sessionInterruptionEnded()
	}
	
	/// Called when the system is notified that a run time error interrupted the Camera session.
	/// - Parameter notification: Notification called when the session has been interupted.
	@objc func sessionRuntimeErrorOccured(notification: Notification) {
		guard let error = notification.userInfo?[AVCaptureSessionErrorKey] as? AVError else {
			return
		}

		print("Capture session runtime error: \(error)")

		if error.code == .mediaServicesWereReset {
			sessionQueue.async {
				if self.isSessionRunning {
					self.startSession()
				} else {
					DispatchQueue.main.async {
						self.delegate?.sessionRunTimeErrorOccured()
					}
				}
			}
		} else {
			self.delegate?.sessionRunTimeErrorOccured()

		}
	}
}

/**
AVCaptureVideoDataOutputSampleBufferDelegate
*/
extension CameraFeedManager: AVCaptureVideoDataOutputSampleBufferDelegate {

	/**
	This method delegates the CVPixelBuffer of the frame seen by the camera currently.
	- Parameters:
	- output: The capture output object.
	- sampleBuffer: A CMSampleBuffer object containing the video frame data and additional information about the frame, such as its format and presentation time.
	- connection: The connection from which the video was received.
	*/
	func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

        var result: Result?
		// Converts the CMSampleBuffer to a CVPixelBuffer.
		let pixelBuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(sampleBuffer)

		guard let imagePixelBuffer = pixelBuffer else {
			return
		}

        
        //executeASLtoText()
		// Delegates the pixel buffer to the ViewController.
		delegate?.didOutput(pixelBuffer: imagePixelBuffer)
	}

}
extension CameraFeedManager{
/// Updates the orientation of the video viewfinder.
	public func updateVideoOrientation( ){
		setPreviewViewOrientaion()
		setVideoOutputOrientaion()
	}
}
