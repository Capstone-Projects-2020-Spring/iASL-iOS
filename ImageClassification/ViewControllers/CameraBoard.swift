//
//  Caboard.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/20/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

/**
Short for camera keyboard. This allows you to use our ASL recognition keyboard as an alternative text input source.
~~~
let textView: UITextView = UITextView()
textView.inputView = CameraBoard(target: textView)
~~~
*/
class CameraBoard: UIView {
	///Container that holds the camera keyboard.
    let caboardView = UIView()
	///Camera view finder.
    let previewView = PreviewView()
	/// keyboard key to act as return key.
    let nextButton = UIButton()
	/// keyboard key to act as delete key.
    let deleteButton = UIButton()
	/// lets the user know the camera isn't working.
    let cameraUnavailableLabel = UILabel()
	/// lets the user resume the camera session.
    let resumeButton = UIButton()
	///UIStackview to hold the four important buttons on the control view
    let buttonStack = UIStackView()
	/// An array of UIButtons that dynamically change based on prediction.
    var predictionButton = [UIButton]()
	/// The stack view that holds the prediction buttons.
    let predictionStack = UIStackView()
	///Short term cache to store the string currently being processed by the keybaord
    var stringCache = String()
	//Viet inspired variables
    
    ///Count for the times output result was verified
    var verificationCount = 0
    ///Short term storage to store the latest predicted output
    var verificationCache = ""
    
	/// The lastLetter predicted.
 	var lastLetter:String?
 	/// Space, del, or nothing predicted.
 	var lastNonLetter: String?
 	/// The number of times a letter reoccured in a prediction
 	var recurCount = 0
 	/// The number of times a nonLetter (Space, del, or nothing) were predicted.
 	var recurCountNonLetter = 0
 	/// the minimum confidence value needed to be inserted into the text view
 	let minimumConfidence: Float = 0.89
	/// Array of string predictions.
    var prediction = ["", "", ""]
    /// Handles all `UITextView` operations such as text insertion, and deletion.
	weak var target: UIKeyInput?
    
	// MARK: Constants
	/// The coded delay for when the model is called to make an inference on the `CVPixelBuffer` in `didOutput()`.
    private let delayBetweenInferencesMs: Double = 1000

    // MARK: Instance Variables
    /// Holds the results at any time
    private var result: Result?
	/// The previous time an inference was taken.
    private var previousInferenceTimeMs: TimeInterval = Date.distantPast.timeIntervalSince1970 * 1000

    // MARK: Controllers that manage functionality
    /// Handles all the camera related functionality
    private lazy var cameraCapture = CameraFeedManager(previewView: previewView)

    /// Handles all data preprocessing and makes calls to run inference through the `Interpreter`.
    private var modelDataHandler: ModelDataHandler? =
        ModelDataHandler(modelFileInfo: MobileNet.modelInfo, labelsFileInfo: MobileNet.labelsInfo)
	
	private var videoModelHandler: VideoModelDataHandler?
	var shouldUseServerModel = true
	/// A set of methods a subclass of UIResponder uses to implement simple text entry.
	/// - Parameter target: The target text view to modify.
	init(target: UIKeyInput) {
		super.init(frame: .zero)
		self.target = target
		autoresizingMask = [.flexibleWidth, .flexibleHeight]
		NotificationCenter.default.addObserver(self, selector: #selector(CameraBoard.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        caboardViewSetup()
        previewViewSetup()
        buttonStackSetup()
        deleteButtonSetup()
        nextButtonSetup()
        bottomCoverSetup()
        predictionStackSetup()
        #if targetEnvironment(simulator)
        previewView.shouldUseClipboardImage = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(classifyPasteboardImage),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        #endif
        cameraCapture.delegate = self
		videoModelHandler = VideoModelDataHandler(cameraBoard: self)
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
	
    ///Required function for checking if there is a fatal error
	/// - Parameter coder: An abstract class that serves as the basis for objects that enable archiving and distribution of other objects.
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Tells the view that its superview is about to change to the specified superview.
	/// - Parameter newSuperview: A view object that will be the new superview of the receiver. This object may be nil.
	override func willMove(toSuperview newSuperview: UIView?) {
		super.willMove(toSuperview: newSuperview)
        #if !targetEnvironment(simulator)
        cameraCapture.checkCameraConfigurationAndStartSession()
        #endif
	}
	/// Overridden by subclasses to perform additional actions before subviews are removed from the view.
	/// - Parameter subview: The subview that will be removed.
	override func willRemoveSubview(_ subview: UIView) {
		super.willRemoveSubview(subview)
		#if !targetEnvironment(simulator)
		cameraCapture.stopSession()
		#endif
	}

}

extension CameraBoard: CameraFeedManagerDelegate {
	/// Shows the current prediction in the prediction stack on the keyboard. The `count` acts as an index, but it is the number of times the letter has occured.
	/// - Parameters:
	///   - prediction: The current prediction.
	///   - confidence: The confidence associated with the prediction.
	///   - count: How many times the prediction was made. Also acts as an index for the `predictionButton` stack.
	fileprivate func showPredictionLetterInStack(_ prediction: String, _ confidence: Float, _ count: Int) {
		if count > 2 {

		} else {
			self.predictionButton[count].setTitle("\(prediction) \(confidence)", for: .normal)
		}
	}
	
	/// This is a temporary function to visualize that delete is being predicted.
	fileprivate func setPredictionToDelete() {
		self.predictionButton[0].setTitle("delete", for: .normal)
		self.predictionButton[1].setTitle("delete", for: .normal)
		self.predictionButton[2].setTitle("delete", for: .normal)
	}
	/// This is a temporary function to visualize that space was predicted.
	fileprivate func setPredictiontoSpace() {
		//                self.stringCache.removeAll()
		self.predictionButton[0].setTitle("space", for: .normal)
		self.predictionButton[1].setTitle("space", for: .normal)
		self.predictionButton[2].setTitle("space", for: .normal)
	}
	/// This may or may not be a temporary function to clear the prediction buttons to an empty string.
	fileprivate func setPredictionToNothing() {
		self.predictionButton[0].setTitle("", for: .normal)
		self.predictionButton[1].setTitle("", for: .normal)
		self.predictionButton[2].setTitle("", for: .normal)
	}

	func didOutput(pixelBuffer: CVPixelBuffer) {
        /// Pass the pixel buffer to TensorFlow Lite to perform inference.
		if shouldUseServerModel{
			videoModelHandler?.runModel(onFrame: pixelBuffer)
		}else{
        result = modelDataHandler?.runModel(onFrame: pixelBuffer)
        if let output = result {
            DispatchQueue.main.async {
                if output.inferences[0].label != "nothing" {
                    self.predictionButton[0].setTitle("\(output.inferences[0].label)", for: .normal)
                }
            
	
				if self.verificationCount == 0 {
					self.verificationCache = output.inferences[0].label
            }
				print("\(self.verificationCount) \(self.verificationCache) == \(output.inferences[0].label)")
				if self.verificationCount == 2 && self.verificationCache == output.inferences[0].label {
					self.verificationCount = 0
                
                let currentTimeMs = Date().timeIntervalSince1970 * 1000
					if (currentTimeMs - self.previousInferenceTimeMs) >= self.delayBetweenInferencesMs{
						self.executeASLtoText()
                    print("pushed")
                } else { return }
					self.previousInferenceTimeMs = currentTimeMs
				} else if self.verificationCount < 2 {
					self.verificationCount += 1
				} else if self.verificationCache != output.inferences[0].label {
					self.verificationCache = ""
					self.verificationCount = 0
            }
			}
        }
		}
    }

	
	/// Executes any Infered ASL Commends such as insertion of a letter, adding space, or deletion.
    func executeASLtoText() {
		//MUST BE ON MAIN THREAD
		DispatchQueue.main.async {
			switch self.result?.inferences[0].label {
			case "del":
				
				self.target?.deleteBackward()
			case "space":
				
				self.target?.insertText(" ")
			case "nothing":
				if true {}
			default:
				if let outputResult = self.result?.inferences[0].label {
					DispatchQueue.main.async {
						self.target?.insertText((self.result?.inferences[0].label)!)
					}
				}
			}
		}
    }

	
	/// Presents alert if camera permission was denied.
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
	
	/// Presents alert if camera configuration has failed.
    func presentVideoConfigurationErrorAlert() {
        let alert = UIAlertController(title: "Camera Configuration Failed", message: "There was an error while configuring camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

//        self.present(alert, animated: true)
        previewView.shouldUseClipboardImage = true
    }
	
   /// Handles session run time error by updating the UI and providing a button if session can be manually resumed.
    func sessionRunTimeErrorOccured() {
        self.resumeButton.isHidden = false
        previewView.shouldUseClipboardImage = true
    }

    // MARK: Session Handling Alerts
	/// Updates the UI when session is interupted.
    func sessionWasInterrupted(canResumeManually resumeManually: Bool) {

        if resumeManually {
            self.resumeButton.isHidden = false
        } else {
            self.cameraUnavailableLabel.isHidden = false
        }
    }
	/// Updates UI once session interruption has ended.
    func sessionInterruptionEnded() {
        if !self.cameraUnavailableLabel.isHidden {
            self.cameraUnavailableLabel.isHidden = true
        }

        if !self.resumeButton.isHidden {
            self.resumeButton.isHidden = true
        }
    }

}

extension CameraBoard {
	
	/// Sets up the position of the prediction buttons.
    func predictionStackSetup() {
        addSubview(predictionStack)
        predictionStack.translatesAutoresizingMaskIntoConstraints = false
        predictionStack.leadingAnchor.constraint(equalTo: previewView.trailingAnchor, constant: 5).isActive = true
        predictionStack.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        predictionStack.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -5).isActive = true
        predictionStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        predictionStack.axis = .vertical
        predictionStack.spacing = 5
        predictionStack.distribution = .fillEqually

        var range = 0
        if prediction.count > 3 {
            range = prediction.count
        } else {
            range = predictionButton.count
        }
        var buttonIndex = 0
        while buttonIndex < 1 {
            predictionButton.append(UIButton())
            predictionStack.addArrangedSubview(predictionButton[buttonIndex])
            predictionStack.translatesAutoresizingMaskIntoConstraints = false
            predictionButton[buttonIndex].titleLabel?.textAlignment = .left
            predictionButton[buttonIndex].setTitle("", for: .normal)
            predictionButton[buttonIndex].titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            predictionButton[buttonIndex].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.2)
            predictionButton[buttonIndex].setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            predictionButton[buttonIndex].addTarget(self, action: #selector(predictionButtonHoldDown(_:)), for: .touchDown)
            predictionButton[buttonIndex].addTarget(self, action: #selector(predictionButtonTapped(_:)), for: .touchUpInside)
            predictionButton[buttonIndex].addTarget(self, action: #selector(predictionButtonTapped(_:)), for: .touchDragExit)
            buttonIndex += 1
        }
    }

	
	/// Called when the prediction button has been held down. Should insert text multiple times.
	/// - Parameter sender: The prediction button.
    @objc func predictionButtonHoldDown(_ sender: UIButton) {
//        for butt in predictionButton {
//            if sender == butt {
//                sender.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.8)
//            }
//        }
    }
	
	/// Called when the prediction button is tapped. Should insert the current prediction.
	/// - Parameter sender: The prediction button.
    @objc func predictionButtonTapped(_ sender: UIButton) {
//        for butt in predictionButton {
//            if sender == butt {
//                sender.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.2)
//                let text = sender.titleLabel?.text
//                for x in 0...stringCache.count {
//                    self.target?.deleteBackward()
//                }
//                if text != nil { self.target?.insertText((sender.titleLabel?.text!)!) } else { self.target?.insertText("")}
//
//                self.target?.insertText(" ")
//            }
//        }
//        prediction.removeAll()
//        print(prediction.count)
//        updateStack(prediction: prediction)
    }
	
	/// Sets up the container for Camera Keyboard.
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
	
	/// Sets up the camera view finder position.
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
	
	/// Sets up the positioning of the `Next` key.
    func nextButtonSetup() {
        buttonStack.addArrangedSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.backgroundColor = #colorLiteral(red: 0.1800611732, green: 0.3206211665, blue: 0.7568627596, alpha: 1)
        nextButton.setTitle("Next", for: .normal)
        nextButton.layer.cornerRadius = 5
		nextButton.addTarget(self, action: #selector(returnKeyPressed), for: .touchUpInside)
	}
	/// Inserts a newline charachter into `target` text view.
	@objc func returnKeyPressed() {
		DispatchQueue.main.async {
			self.target?.insertText("\n")
		}
	}
	///Function to setup the dashboard
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
	
	/// Sets up the position of the delete key.
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
        longPressGestureRecognizer.cancelsTouchesInView = false
		self.addGestureRecognizer(longPressGestureRecognizer)
    }
	
	/// Handles long press on delete key.
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
	/// deletes charachter.
	/// - Parameter completion: This completion handler lets you run code after deletetion. This is pretty much unused.
	@objc func deleteChar(completion:@escaping () -> Void) {
		DispatchQueue.main.async {
			self.target?.deleteBackward()
		}

	}
	
	/// Adds a nice cover for devices without a homebutton.
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
extension CameraBoard {
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
	fileprivate func setPreviewViewOrientaion() {
		switch UIDevice.current.orientation {
		case .portrait:
			previewView.previewLayer.connection?.videoOrientation = .portrait
		case .landscapeLeft:
			previewView.previewLayer.connection?.videoOrientation = .landscapeRight
		case .landscapeRight:
			previewView.previewLayer.connection?.videoOrientation = .landscapeLeft
		case .portraitUpsideDown:
			previewView.previewLayer.connection?.videoOrientation = .portraitUpsideDown
		default:
			previewView.previewLayer.connection?.videoOrientation = .landscapeRight
		}
	}
	/// Function to determine rotation.
	@objc func rotated() {
		setServerModel()
		setPreviewViewOrientaion()
		if UIDevice.current.orientation.isLandscape {
        print("Landscape")
		}

		if UIDevice.current.orientation.isPortrait {
        print("Portrait")
		}
	}
	fileprivate func setServerModel() {
		DispatchQueue.main.async {
			switch UIDevice.current.orientation.isPortrait {
			case true:
				print("Don't use server model")
				self.shouldUseServerModel = false
			case false:
				print("USE SERVER MODEL")
				self.shouldUseServerModel = true
			
			}
		
		}
	}
}
