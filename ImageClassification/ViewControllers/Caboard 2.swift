//
//  Caboard.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/20/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class Caboard: UIView {

    let caboardView = UIView()
    let previewView = PreviewView()
    let nextButton = UIButton()
    let deleteButton = UIButton()
    let cameraUnavailableLabel = UILabel()
    let resumeButton = UIButton()
    let buttonStack = UIStackView()
    let predictionTable = UITableView()
    let keyboardChangeButton = UIButton()

    var prediction = ["He", "Hey", "Here"]
	weak var target: UIKeyInput?
    // MARK: Constants
    private let animationDuration = 0.5
    private let collapseTransitionThreshold: CGFloat = -40.0
    private let expandThransitionThreshold: CGFloat = 40.0
    private let delayBetweenInferencesMs: Double = 1000

    // MARK: Instance Variables
    // Holds the results at any time
    private var result: Result?
    private var initialBottomSpace: CGFloat = 0.0
    private var previousInferenceTimeMs: TimeInterval = Date.distantPast.timeIntervalSince1970 * 1000

    // MARK: Controllers that manage functionality
    // Handles all the camera related functionality
    private lazy var cameraCapture = CameraFeedManager(previewView: previewView)

    // Handles all data preprocessing and makes calls to run inference through the `Interpreter`.
    private var modelDataHandler: ModelDataHandler? =
        ModelDataHandler(modelFileInfo: MobileNet.modelInfo, labelsFileInfo: MobileNet.labelsInfo)

	init(target: UIKeyInput) {
		super.init(frame: .zero)
		self.target = target
		autoresizingMask = [.flexibleWidth, .flexibleHeight]
        caboardViewSetup()
        previewViewSetup()
        buttonStackSetup()
        deleteButtonSetup()
        nextButtonSetup()
        predictionTableSetup()
        bottomCoverSetup()

        //composedMessageSetup()

        #if targetEnvironment(simulator)
        previewView.shouldUseClipboardImage = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(classifyPasteboardImage),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        #endif
        cameraCapture.delegate = self
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)

    }

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func willMove(toSuperview newSuperview: UIView?) {
		super.willMove(toSuperview: newSuperview)
        #if !targetEnvironment(simulator)
        cameraCapture.checkCameraConfigurationAndStartSession()
        #endif
	}
	override func willRemoveSubview(_ subview: UIView) {
		super.willRemoveSubview(subview)
		#if !targetEnvironment(simulator)
		cameraCapture.stopSession()
		#endif
	}

}

extension Caboard: CameraFeedManagerDelegate {
    func didOutput(pixelBuffer: CVPixelBuffer) {
        let currentTimeMs = Date().timeIntervalSince1970 * 1000
        guard (currentTimeMs - previousInferenceTimeMs) >= delayBetweenInferencesMs else { return }
        previousInferenceTimeMs = currentTimeMs

        // Pass the pixel buffer to TensorFlow Lite to perform inference.
        result = modelDataHandler?.runModel(onFrame: pixelBuffer)
		DispatchQueue.main.async {
			switch self.result?.inferences[0].label {
			case "del":

				self.target?.deleteBackward()

			case "space":

				self.target?.insertText(" ")
			case "nothing":
				break
			default:

				self.target?.insertText(self.result!.inferences[0].label.description)

			}
		}

        // Display results by handing off to the InferenceViewController.
        DispatchQueue.main.async {
            let resolution = CGSize(width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))

        }
    }

    func presentCameraPermissionsDeniedAlert() {
        let alertController = UIAlertController(title: "Camera Permissions Denied", message: "Camera permissions have been denied for this app. You can change this by going to Settings", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)

//        present(alertController, animated: true, completion: nil)

        previewView.shouldUseClipboardImage = true
    }

    func presentVideoConfigurationErrorAlert() {
        let alert = UIAlertController(title: "Camera Configuration Failed", message: "There was an error while configuring camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

//        self.present(alert, animated: true)
        previewView.shouldUseClipboardImage = true
    }

    func sessionRunTimeErrorOccured() {
        // Handles session run time error by updating the UI and providing a button if session can be manually resumed.
        self.resumeButton.isHidden = false
        previewView.shouldUseClipboardImage = true
    }

    // MARK: Session Handling Alerts
    func sessionWasInterrupted(canResumeManually resumeManually: Bool) {

        // Updates the UI when session is interupted.
        if resumeManually {
            self.resumeButton.isHidden = false
        } else {
            self.cameraUnavailableLabel.isHidden = false
        }
    }

    func sessionInterruptionEnded() {
        // Updates UI once session interruption has ended.
        if !self.cameraUnavailableLabel.isHidden {
            self.cameraUnavailableLabel.isHidden = true
        }

        if !self.resumeButton.isHidden {
            self.resumeButton.isHidden = true
        }
    }

}

extension Caboard: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prediction.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = prediction[indexPath.row]
        cell?.textLabel?.textColor = .white
        cell?.backgroundColor = .clear
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        outputText.append(prediction[indexPath.row])

		DispatchQueue.main.async {
//			print(self.outputText)
			self.target?.insertText(self.prediction[indexPath.row])
		}
    }

}

extension Caboard {

    func caboardViewSetup() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = caboardView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        caboardView.addSubview(blurEffectView)

        addSubview(caboardView)
        caboardView.translatesAutoresizingMaskIntoConstraints = false
//		caboardView.bottomAnchor.constraint(equalTo: (viewDelagate?.safeAreaLayoutGuide.bottomAnchor)!).isActive = true
//		caboardView.leadingAnchor.constraint(equalTo: viewDelagate!.leadingAnchor).isActive = true
//		caboardView.trailingAnchor.constraint(equalTo: viewDelagate!.trailingAnchor).isActive = true
        caboardView.heightAnchor.constraint(equalToConstant: 230).isActive = true

        caboardView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }

    func previewViewSetup() {
        caboardView.addSubview(previewView)
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        previewView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
		previewView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
		previewView.heightAnchor.constraint(equalToConstant: 215).isActive = true
		previewView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
//		previewView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        previewView.backgroundColor = .black
    }

    func nextButtonSetup() {
        buttonStack.addArrangedSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.backgroundColor = #colorLiteral(red: 0.1800611732, green: 0.3206211665, blue: 0.7568627596, alpha: 1)
        nextButton.setTitle("Next", for: .normal)
        nextButton.layer.cornerRadius = 5
		nextButton.addTarget(self, action: #selector(returnKeyPressed), for: .touchUpInside)
    }
	@objc func returnKeyPressed() {
		DispatchQueue.main.async {
			self.target?.insertText("\n")
		}
	}
    func buttonStackSetup() {
        addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.leadingAnchor.constraint(equalTo: previewView.trailingAnchor, constant: 5).isActive = true
		buttonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        buttonStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        buttonStack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 5
    }

    func predictionTableSetup() {
        caboardView.addSubview(predictionTable)
        predictionTable.translatesAutoresizingMaskIntoConstraints = false
        predictionTable.leadingAnchor.constraint(equalTo: previewView.trailingAnchor, constant: 5).isActive = true
        predictionTable.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -5).isActive = true
        predictionTable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        predictionTable.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        predictionTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        predictionTable.backgroundColor = .clear
        predictionTable.separatorColor = .white
        predictionTable.delegate = self
        predictionTable.dataSource = self
    }

    func deleteButtonSetup() {
        buttonStack.addArrangedSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        deleteButton.setTitle("⌫", for: .normal)
        deleteButton.layer.cornerRadius = 5
		deleteButton.accessibilityTraits = [.keyboardKey]
        deleteButton.accessibilityLabel = "Delete"
		deleteButton.addTarget(self, action: #selector(deleteChar), for: .touchUpInside)
//		deleteButton.addTarget(self, action: #selector(deleteChar), for: .touchDown)
		// Add Gesture Recognizer to view

		let longPressGestureRecognizer = UILongPressGestureRecognizer(
					target: self,
					action: #selector(handleLongPress))

		self.addGestureRecognizer(longPressGestureRecognizer)
    }
	@objc func handleLongPress() {
		deleteChar {
			#if DEBUG
			if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
					// Code only executes when tests are running
				print("SUgma")
				}
			#endif
		}
	}
	@objc func deleteChar(completion:@escaping () -> Void) {
		DispatchQueue.main.async {
			self.target?.deleteBackward()
		}

	}
    func keyboardButtonSetup() {
        buttonStack.addArrangedSubview(keyboardChangeButton)
        keyboardChangeButton.translatesAutoresizingMaskIntoConstraints = false
        keyboardChangeButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        keyboardChangeButton.setImage(#imageLiteral(resourceName: "keyboard"), for: .normal)
    }

    func bottomCoverSetup() {
        let bottomCover = UIView()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bottomCover.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bottomCover.addSubview(blurEffectView)

        addSubview(bottomCover)
        bottomCover.translatesAutoresizingMaskIntoConstraints = false
        bottomCover.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomCover.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomCover.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomCover.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomCover.backgroundColor = .white
    }

}
extension Caboard {
    @objc func classifyPasteboardImage() {
        guard let image = UIPasteboard.general.images?.first else {
            return
        }

        guard let buffer = CVImageBuffer.buffer(from: image) else {
            return
        }

        previewView.image = image

        DispatchQueue.global().async {
            self.didOutput(pixelBuffer: buffer)
        }
    }
}