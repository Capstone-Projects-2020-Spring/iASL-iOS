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

import AVFoundation
import UIKit
import Speech
import Firebase

class ViewController: UIViewController {
//	var isFirstOpen = true
    let remoteChatButton = UIButton()
    let liveChatButton = UIButton()
    let notesButton = UIButton()
    let buttonStack = UIStackView()
    let liveButton = UIButton()
    let tabController = UITabBarController()
    let outputTextView = UITextView()
    let textViewHolder = UIView()
    let speakerButton = UIButton()
    let clearButton = UIButton()
    let keyboardButton = UIButton()
    var heightAnchor = NSLayoutConstraint()
	var helpUsTrainConfig = HelpTrainWelcomeConfiguration()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var synthesizer = AVSpeechSynthesizer()

    let topBar = UIView()
    // MARK: Storyboards Connections
    var previewView = PreviewView()
    let cameraUnavailableLabel = UILabel()
    let resumeButton = UIButton()

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

    // Handles the presenting of results on the screen

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {

            ///Code for darmode
            if self.traitCollection.userInterfaceStyle == .dark {

            } else { ///Code for light mode

            }
        }

    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
            liveButton.isSelected = true
            notesButton.isHidden = true
            remoteChatButton.isHidden = true
            let vc = SpeechToTextVC()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: {vc.view.rotate(angle: 180)})
            //
        } else {
            liveButton.isSelected = false
            remoteChatButton.isHidden = false
            notesButton.isHidden = false
            dismiss(animated: true, completion: nil)
        }

    }

    // MARK: View Handling Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        previewViewSetup()
        textViewHolderSetup()
        outputTextViewSetup()
        topBarSetup()
        cameraUnavailableLabelSetup()
        notesButtonSetup()
        remoteChatButtonSetup()
        resumeButtonSetup()
        liveButtonSetup()

        speakerButtonSetup()
        clearButtonSetup()
        keyboardButtonSetup()
        //speak()
        if speakerButton.isSelected == true {
            speak()
        }
        //speak()

        //        let child = CardView()
        //        addChild(child)
        //        child.view.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        //        view.addSubview(child.view)
        //        child.didMove(toParent: self)

        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipeGesture(_:)))
        view.addGestureRecognizer(swipeLeftGestureRecognizer)
        swipeLeftGestureRecognizer.direction = .left

        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUpGesture(_:)))
        view.addGestureRecognizer(swipeUpGestureRecognizer)
        swipeUpGestureRecognizer.direction = .up

        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleDownSwipeGesture(_:)))
        view.addGestureRecognizer(swipeDownGestureRecognizer)
        swipeDownGestureRecognizer.direction = .down

        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipeGesture(_:)))
        view.addGestureRecognizer(swipeRightGestureRecognizer)
        swipeRightGestureRecognizer.direction = .right

        guard modelDataHandler != nil else {
            fatalError("Model set up failed")
        }

        #if targetEnvironment(simulator)
        previewView.shouldUseClipboardImage = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(classifyPasteboardImage),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        #endif
        cameraCapture.delegate = self

    }

    @objc func handleSwipeUpGesture(_ sender: UISwipeGestureRecognizer) {
        textViewHolder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //textViewHolder.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        UIView.animate(withDuration: 0.2, animations: {
            self.heightAnchor.constant = -self.view.frame.size.height/2
            self.outputTextView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.6)
            self.view.layoutIfNeeded()
        })

    }

    @objc func handleDownSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        textViewHolder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //textViewHolder.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        UIView.animate(withDuration: 0.2, animations: {
            self.heightAnchor.constant = -self.view.frame.size.height/4
            self.outputTextView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.view.layoutIfNeeded()
        })
    }

    @objc func handleLeftSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        let vc = NotesVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @objc func handleRightSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        let vc = RemoteConversationVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if !targetEnvironment(simulator)
        cameraCapture.checkCameraConfigurationAndStartSession()
        #endif
    }

    #if !targetEnvironment(simulator)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraCapture.stopSession()
    }
    #endif

    ///This indicates the color of the status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func presentUnableToResumeSessionAlert() {
        let alert = UIAlertController(
            title: "Unable to Resume Session",
            message: "There was an error while attempting to resume session.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }

    ///Prepare for Segue to next storyboard view controller.
    // MARK: Storyboard Segue Handlers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == "EMBED" {

            guard let tempModelDataHandler = modelDataHandler else {
                return
            }

        }
    }

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

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: CameraFeedManagerDelegate Methods
extension ViewController: CameraFeedManagerDelegate {

	func didOutput(pixelBuffer: CVPixelBuffer) {
        let currentTimeMs = Date().timeIntervalSince1970 * 1000
        guard (currentTimeMs - previousInferenceTimeMs) >= delayBetweenInferencesMs else { return }
        previousInferenceTimeMs = currentTimeMs

        // Pass the pixel buffer to TensorFlow Lite to perform inference.
        result = modelDataHandler?.runModel(onFrame: pixelBuffer)
		executeASLtoText()
        // Display results by handing off to the InferenceViewController.
        DispatchQueue.main.async {
            let resolution = CGSize(width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))

        }
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

    func sessionRunTimeErrorOccured() {
        // Handles session run time error by updating the UI and providing a button if session can be manually resumed.
        self.resumeButton.isHidden = false
        previewView.shouldUseClipboardImage = true
    }

    func presentCameraPermissionsDeniedAlert() {
        let alertController = UIAlertController(title: "Camera Permissions Denied", message: "Camera permissions have been denied for this app. You can change this by going to Settings", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)

        present(alertController, animated: true, completion: nil)

        previewView.shouldUseClipboardImage = true
    }

    func presentVideoConfigurationErrorAlert() {
        let alert = UIAlertController(title: "Camera Configuration Failed", message: "There was an error while configuring camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
        previewView.shouldUseClipboardImage = true
    }
}

extension ViewController {

    func previewViewSetup() {
        view.addSubview(previewView)
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        previewView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func topBarSetup() {
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 90).isActive = true
        //topBar.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }

    func cameraUnavailableLabelSetup() {
        view.addSubview(cameraUnavailableLabel)
        cameraUnavailableLabel.translatesAutoresizingMaskIntoConstraints = false
        cameraUnavailableLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cameraUnavailableLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cameraUnavailableLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cameraUnavailableLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        cameraUnavailableLabel.text = "Camera Unavailable"
        cameraUnavailableLabel.textAlignment = .center
        cameraUnavailableLabel.font = UIFont.boldSystemFont(ofSize: 30)
        cameraUnavailableLabel.textColor = .white
        cameraUnavailableLabel.isHidden = true
    }

    func resumeButtonSetup() {
        view.addSubview(resumeButton)
        resumeButton.translatesAutoresizingMaskIntoConstraints = false
        resumeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resumeButton.topAnchor.constraint(equalTo: cameraUnavailableLabel.bottomAnchor, constant: 20).isActive = true
        resumeButton.setTitle("Resume Session", for: .normal)
        resumeButton.setTitleColor(.yellow, for: .normal)
        resumeButton.isHidden = true
    }

    func remoteChatButtonSetup() {
        view.addSubview(remoteChatButton)
        remoteChatButton.translatesAutoresizingMaskIntoConstraints = false
        remoteChatButton.setImage(#imageLiteral(resourceName: "chatIcon"), for: .normal)
        remoteChatButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        remoteChatButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        remoteChatButton.imageView?.contentMode = .scaleAspectFit
        remoteChatButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        remoteChatButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        //remoteChatButton.setTitle("Chat", for: .normal)
        remoteChatButton.addTarget(self, action: #selector(remoteChatButtonTapped), for: .touchUpInside)
    }

    @objc func remoteChatButtonTapped() {

        //check if user is logged in, if not go to login screen
        checkIfLoggedOut()

        let vc = RemoteConversationVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        remoteChatButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        remoteChatButton.setTitleColor(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), for: .normal)
        present(vc, animated: true, completion: nil)
        //navigationController?.pushViewController(vc, animated: true)
    }

    func liveButtonSetup() {
        view.addSubview(liveButton)
        liveButton.translatesAutoresizingMaskIntoConstraints = false
        //liveButton.setTitle("Live", for: .normal)
        liveButton.setImage(#imageLiteral(resourceName: "yo"), for: .normal)
        liveButton.imageView?.contentMode = .scaleAspectFit
        liveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        liveButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        liveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        liveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        liveButton.addTarget(self, action: #selector(liveButtonTapped), for: .touchUpInside)
    }

    @objc func liveButtonTapped() {
        liveButton.isSelected = true
        let vc = SpeechToTextVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)

    }

    func notesButtonSetup() {
        view.addSubview(notesButton)
        notesButton.translatesAutoresizingMaskIntoConstraints = false
        notesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        notesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        notesButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        notesButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        notesButton.setImage(#imageLiteral(resourceName: "notesIcon"), for: .normal)
        //notesButton.setTitle("Notes", for: .normal)
        notesButton.addTarget(self, action: #selector(notesButtonTapped), for: .touchUpInside)

        notesButton.imageView?.contentMode = .scaleAspectFit
    }

    ///checks if there is a user logged in. If there is not, it opens the login VC
    func checkIfLoggedOut() {
        if Auth.auth().currentUser?.uid == nil {
            //present the login screen
            print("user is not signed in")
            let loginController = LoginVC()
            loginController.modalTransitionStyle = .crossDissolve
            loginController.modalPresentationStyle = .fullScreen
            present(loginController, animated: true, completion: nil)
            return
        }
    }

    @objc func notesButtonTapped() {

        //check if user is logged in, if not go to login screen
        checkIfLoggedOut()

        notesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        notesButton.setTitleColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), for: .selected)
        let vc = NotesVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
        //navigationController?.pushViewController(vc, animated: true)
    }

    func textViewHolderSetup() {
        view.addSubview(textViewHolder)
        textViewHolder.translatesAutoresizingMaskIntoConstraints = false
        heightAnchor = textViewHolder.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.size.height/2)
        //textViewHolder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textViewHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textViewHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textViewHolder.heightAnchor.constraint(equalToConstant: view.frame.size.height/2).isActive = true
        heightAnchor.isActive = true
        textViewHolder.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textViewHolder.layer.cornerRadius = 20
        textViewHolder.clipsToBounds = true
        textViewHolder.isUserInteractionEnabled = true

    }

    func outputTextViewSetup() {
        textViewHolder.addSubview(outputTextView)
        outputTextView.translatesAutoresizingMaskIntoConstraints = false
        outputTextView.bottomAnchor.constraint(equalTo: textViewHolder.bottomAnchor).isActive = true
        outputTextView.leadingAnchor.constraint(equalTo: textViewHolder.leadingAnchor).isActive = true
        outputTextView.trailingAnchor.constraint(equalTo: textViewHolder.trailingAnchor).isActive = true
        outputTextView.topAnchor.constraint(equalTo: textViewHolder.topAnchor).isActive = true
        outputTextView.isEditable = false
        outputTextView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.8)
        outputTextView.text = "The quick brown fox jumps over the lazy dog"
        outputTextView.textColor = .black
        outputTextView.font = UIFont.boldSystemFont(ofSize: 30)
        outputTextView.isUserInteractionEnabled = true
    }

    func speak() {
        let utterance = AVSpeechUtterance(string: outputTextView.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.4

        synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }

    func speakerButtonSetup() {
        view.addSubview(speakerButton)
        speakerButton.translatesAutoresizingMaskIntoConstraints = false
        speakerButton.trailingAnchor.constraint(equalTo: textViewHolder.trailingAnchor, constant: -20).isActive = true
        speakerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        speakerButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        speakerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        speakerButton.backgroundColor = #colorLiteral(red: 0.2958290193, green: 0.29024376, blue: 1, alpha: 1)
        speakerButton.setTitle("Speak", for: .normal)
        speakerButton.setTitle("Mute", for: .selected)
        speakerButton.isSelected = true
        speakerButton.layer.cornerRadius = 10
        speakerButton.addTarget(self, action: #selector(speakerButtonTapped), for: .touchUpInside)
    }

    @objc func speakerButtonTapped() {
        if speakerButton.isSelected == true {
            speakerButton.isSelected = false
            speakerButton.backgroundColor = .gray
            synthesizer.stopSpeaking(at: .word)
        } else {
            speakerButton.isSelected = true
            speak()
            speakerButton.backgroundColor = #colorLiteral(red: 0.2958290193, green: 0.29024376, blue: 1, alpha: 1)
        }
    }

    func clearButtonSetup() {
        view.addSubview(clearButton)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.trailingAnchor.constraint(equalTo: speakerButton.leadingAnchor, constant: -10).isActive = true
        clearButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        clearButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        clearButton.backgroundColor = #colorLiteral(red: 0.2958290193, green: 0.29024376, blue: 1, alpha: 1)
        clearButton.setTitle("Clear", for: .normal)
        clearButton.isSelected = true
        clearButton.layer.cornerRadius = 10
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }

    @objc func clearButtonTapped() {
        outputTextView.text.removeAll()
    }

    func keyboardButtonSetup() {
        view.addSubview(keyboardButton)
        keyboardButton.translatesAutoresizingMaskIntoConstraints = false
        keyboardButton.trailingAnchor.constraint(equalTo: clearButton.leadingAnchor, constant: -10).isActive = true
        keyboardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        keyboardButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        keyboardButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        keyboardButton.backgroundColor = #colorLiteral(red: 0.2958290193, green: 0.29024376, blue: 1, alpha: 1)
        keyboardButton.setTitle("Keyboard", for: .normal)
        keyboardButton.isSelected = true
        keyboardButton.layer.cornerRadius = 10
        keyboardButton.addTarget(self, action: #selector(keyboardButtonTapped), for: .touchUpInside)
    }
	@objc func keyboardButtonTapped() {
		   textViewHolder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		   textViewHolder.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

		   if keyboardButton.isSelected {
			   print("ss")
			   keyboardButton.isSelected = false
			   UIView.animate(withDuration: 0.2, animations: {
				   self.heightAnchor.constant = -self.view.frame.size.height/2
				   self.textViewHolder.layer.cornerRadius = 10
				   self.view.layoutIfNeeded()
			   })
		   } else {
			   keyboardButton.isSelected = true
			   outputTextView.topAnchor.constraint(equalTo: textViewHolder.topAnchor, constant: 30).isActive = true
			   UIView.animate(withDuration: 0.2, animations: {
				   self.heightAnchor.constant = -self.view.frame.size.height
				   self.textViewHolder.backgroundColor = .white
				   self.textViewHolder.layer.cornerRadius = 0
				   self.view.layoutIfNeeded()
			   })
		   }

	   }

    @objc func collapseButtonTapped() {
        //textViewHolder
    }

}
extension ViewController {
	func deleteCharacter() {
		DispatchQueue.main.async {
            if self.outputTextView.text != "" {
				var text = self.outputTextView.text
                text?.removeLast()
                self.outputTextView.text = text
            }
		}
	}
	func addSpace() {
		DispatchQueue.main.async {
            if self.outputTextView.text != "" {
				var text = self.outputTextView.text
                text?.append(" ")
                self.outputTextView.text = text
            }
		}
	}

	func executeASLtoText() {
		switch result?.inferences[0].label {
		case "del":
			deleteCharacter()
		case "space":
			addSpace()
		case "nothing":
			print("")
		default:
			DispatchQueue.main.async {
				self.outputTextView.text += self.result!.inferences[0].label.description
			}
		}
	}

}
