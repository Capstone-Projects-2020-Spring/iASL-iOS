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
import KeychainSwift

class ViewController: UIViewController {
    
    //MARK: Global Constants
    ///The read hollow box that shows the area where the video is being fetched from
    let areaBound = UIView()
    ///Button to move to chat viewcontroller
    let remoteChatButton = UIButton()
    ///Button to move to notes viewcontroller
    let notesButton = UIButton()
    ///Button to transition between speech to text
    let liveButton = UIButton()
    ///UITextView to show the letters/words predicted by the model
    let outputTextView = UITextView()
    ///UIViewView for dashboard outputtextview
    let textViewHolder = UIView()
    ///Button to invoke speach to text
    let speakerButton = UIButton()
    ///UIStackview to hold the four essentail buttons of the dashboard
    let controlButtonStack = UIStackView()
    ///Button to clear the outputTextview
    let clearButton = UIButton()
    ///Button to raise the screen and show the keybaord, prompting the user to type
    let keyboardButton = UIButton()
    ///Button for users to open training mode
    let trainButton = UIButton()

    var heightAnchor = NSLayoutConstraint()
    var controlViewHeightAnchor = NSLayoutConstraint()
    let logOutButton = UIButton()

    let controlView = UIView()
    ///Button to expand and collapse the dashboard
    let controlButton = UIButton()
    ///UISlider for controlling the speed of the voice
    let slider = UISlider()
    ///Variable to keep track of the voice utterance
    var speechSpeedDegree = Float()
    ///Button to activate prediction assistant
    @objc let predictionAssistButton = UIButton()
    ///Variable for prediction layer to carry out predictions
    let predictionLayer = PredictionLayer()
    ///Syntesizer to generate from text to speech
    var synthesizer = AVSpeechSynthesizer()
    ///Tracker for how many time the output from the model has been verified
    var verificationCount = 0
    ///Cache to store result from last prediction
    var verificationCache = ""
    ///UIView for top bar
    let topBar = UIView()
    // MARK: Storyboards Connections
    ///Preview view to show the video preview from camera
    let previewView = PreviewView()
    ///Error message to show when the camera is unavailable
    let cameraUnavailableLabel = UILabel()
    ///Button to resume camera operation
    let resumeButton = UIButton()
    
    ///Keychain reference for when we need to clear the keychain if someone logs out
    let keychain = KeychainSwift(keyPrefix: "iasl_")

    // MARK: Global Variables
    ///Constraint to keep track of the height of the output text view, whether it's collapsed or expanded
    var heightAnchor = NSLayoutConstraint()
    ///Constraint to keep track of the heigh of the dashboard, whether it's collapsed or expanded
    var controlViewHeightAnchor = NSLayoutConstraint()
    ///Delay inbetween the prediction by the model (How often the app outputs a letter/word)
    private let delayBetweenInferencesMs: Double = 1000

    // MARK: Instance Variables
    ///Result that's output by the model
    private var result: Result?
    ///Time from the previous prediction
    private var previousInferenceTimeMs: TimeInterval = Date.distantPast.timeIntervalSince1970 * 1000

	
    // MARK: Controllers that manage functionality
    /// Handles all the camera related functionality
    private lazy var cameraCapture = CameraFeedManager(previewView: previewView)

    /// Handles all data preprocessing and makes calls to run inference through the `Interpreter`.
    private var modelDataHandler: ModelDataHandler? =
        ModelDataHandler(modelFileInfo: MobileNet.modelInfo, labelsFileInfo: MobileNet.labelsInfo, threadCount: 2)

        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		// check current view controller
		guard let currentPresentedViewController = self.presentedViewController else {
			// if its the main view controller check if its upside down
        if UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
            liveButton.isSelected = true
            notesButton.isHidden = true
            remoteChatButton.isHidden = true
            let vc = SpeechToTextVC()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: {vc.view.rotate(angle: 180)})
            //
			}
			return
		}
		// if the view controller is presenting speech to text
		if currentPresentedViewController is SpeechToTextVC {
			// if rotated back to portrait orientation dismiss.
			if UIDevice.current.orientation == UIDeviceOrientation.portrait {
				liveButton.isSelected = false
				remoteChatButton.isHidden = false
				notesButton.isHidden = false
				dismiss(animated: true, completion: nil)
			}
		}
		
    }

    // MARK: View Handling Methods
    ///Main function to call all the necessary GUI and backend functions
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
        controlViewSetup()

        controlButtonStackSetup()
        controlButtonSetup()
        speakerButtonSetup()
        clearButtonSetup()
        keyboardButtonSetup()
        trainButtonSetup()
        logOutButtonSetup()
        predictionAssistButtonSetup()
        sliderSetup()
        areaBoundSetup()
        //hideKeyboardWhenTappedAround()
        //speak()



        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipeGesture(_:)))
        previewView.addGestureRecognizer(swipeLeftGestureRecognizer)
        swipeLeftGestureRecognizer.direction = .left
        ///Add up swipe gesture and assign a function to invoke when swiped up
        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUpGesture(_:)))
        view.addGestureRecognizer(swipeUpGestureRecognizer)
        swipeUpGestureRecognizer.direction = .up
        ///Add down swipe gesture and assign a function to invoke when swiped down
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleDownSwipeGesture(_:)))
        view.addGestureRecognizer(swipeDownGestureRecognizer)
        swipeDownGestureRecognizer.direction = .down
        ///Add right swipe gesture and assign a function to invoke when swiped right
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipeGesture(_:)))
        previewView.addGestureRecognizer(swipeRightGestureRecognizer)
        swipeRightGestureRecognizer.direction = .right

        ///Initialize the machine learning model
        guard modelDataHandler != nil else {
            fatalError("Model set up failed")
        }
        
        ///Handles exception handler when camera is not available
        #if targetEnvironment(simulator)
        previewView.shouldUseClipboardImage = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(classifyPasteboardImage),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        #endif
        cameraCapture.delegate = self
    }

    ///Raise the whoe View when the keybaord appears
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    ///Lower the keyboard down when the keyboard disappears
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    
    
    /// Action invoked when swiped up
    /// - Parameter sender: the gesture recognizer itself
    @objc func handleSwipeUpGesture(_ sender: UISwipeGestureRecognizer) {
        textViewHolder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //textViewHolder.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        print("adaf")
        UIView.animate(withDuration: 0.2, animations: {
            self.heightAnchor.constant = -self.view.frame.size.height/2
            self.outputTextView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.6)
            self.textViewHolder.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.6)
            self.view.layoutIfNeeded()
        })

    }


    /// Action invoked when swiped down
    /// - Parameter sender: the gesture recognizer itself
    @objc func handleDownSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        textViewHolder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //textViewHolder.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        ///Animattion when swiped down

        UIView.animate(withDuration: 0.2, animations: {
            self.heightAnchor.constant = -self.view.frame.size.height/4
            self.outputTextView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.view.layoutIfNeeded()
        })
    }

    /// Action invoked when swiped left
    /// - Parameter sender: the gesture recognizer itself
    @objc func handleLeftSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        let vc = NotesVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    /// Action invoked when swiped right
    /// - Parameter sender: the gesture recognizer itself
    @objc func handleRightSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        let vc = RemoteConversationVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    
    /// Configure the view when it appears
    /// - Parameter animated: boolean value if animation is necessary
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if !targetEnvironment(simulator)
        cameraCapture.checkCameraConfigurationAndStartSession()
        #endif
    }

    #if !targetEnvironment(simulator)
    /// Configures screen when it dissappears
    /// - Parameter animated: boolean value if animation is necessary
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraCapture.stopSession()
    }
    #endif

    ///Indicates the color of the status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// Present error if the app unable to resume
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
    
    /// Invoke the model to identify from the given image in pasteboard
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
        /// Pass the pixel buffer to TensorFlow Lite to perform inference.
        result = modelDataHandler?.runModel(onFrame: pixelBuffer)
        if let output = result {
            if output.inferences[0].label != "nothing" {
                print("\(output.inferences[0].label) \(output.inferences[0].confidence)")
            }
            if verificationCount == 0 {
                verificationCache = output.inferences[0].label
            }
            print("\(verificationCount) \(verificationCache) == \(output.inferences[0].label)")
            if verificationCount == 2 && verificationCache == output.inferences[0].label {
                verificationCount = 0
                
                let currentTimeMs = Date().timeIntervalSince1970 * 1000
                if (currentTimeMs - previousInferenceTimeMs) >= delayBetweenInferencesMs{
                    executeASLtoText()
                    print("pushed")
                } else { return }
                previousInferenceTimeMs = currentTimeMs
                
                
            } else if verificationCount < 2 {
                verificationCount += 1
            } else if verificationCache != output.inferences[0].label {
                verificationCache = ""
                verificationCount = 0
            }
        }
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

    ///Setup the preview to show the live feed from the camera on screen
    func previewViewSetup() {
        view.addSubview(previewView)
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        previewView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    /// Setup top bar area to host top three buttons
    func topBarSetup() {
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 90).isActive = true
        //topBar.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    ///Setup the view the error message that the camera is not available
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

    ///Setup the button to resume the camera operation
    func resumeButtonSetup() {
        view.addSubview(resumeButton)
        resumeButton.translatesAutoresizingMaskIntoConstraints = false
        resumeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resumeButton.topAnchor.constraint(equalTo: cameraUnavailableLabel.bottomAnchor, constant: 20).isActive = true
        resumeButton.setTitle("Resume Session", for: .normal)
        resumeButton.setTitleColor(.yellow, for: .normal)
        resumeButton.isHidden = true
    }

    
    ///Setup the remote chat button and add it on the view
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

    ///Action when the remote chat button is tapped. Present RemoteConversationVC
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

    ///Setup live button, Presentes SpeechToTextVC VC
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

    ///Action for live button to present SpeechToTextVC on screen
    @objc func liveButtonTapped() {
        liveButton.isSelected = true
        let vc = SpeechToTextVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)

    }
    
    ///Setup note button on screen
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
    
    /**
     Checks if the user is logged out so we can disable the log out button
     - Returns: True if user is not looged in, false otherwise
     */
    func userIsLoggedOut() -> Bool {
        if Auth.auth().currentUser?.uid == nil {
            print("user is not signed in")
            return true
        }
        return false
    }

    ///Action for note button. Presenets NoteVC
    @objc func notesButtonTapped() {

        //check if user is logged in, if not go to login screen
        checkIfLoggedOut()

        notesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        notesButton.setTitleColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), for: .selected)
        //let vc = notesVC
        let vc = NotesVC()
        //vc.notesVC = vc
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
        //navigationController?.pushViewController(vc, animated: true)
    }

    ///Setup position/size/style of the textview holder and add it on screen
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

    ///Setup position/size/style of the outputtextview holder and add it on screen
    func outputTextViewSetup() {
        textViewHolder.addSubview(outputTextView)
        outputTextView.translatesAutoresizingMaskIntoConstraints = false
        outputTextView.bottomAnchor.constraint(equalTo: textViewHolder.bottomAnchor).isActive = true
        outputTextView.leadingAnchor.constraint(equalTo: textViewHolder.leadingAnchor).isActive = true
        outputTextView.trailingAnchor.constraint(equalTo: textViewHolder.trailingAnchor).isActive = true
        outputTextView.topAnchor.constraint(equalTo: textViewHolder.topAnchor).isActive = true
        outputTextView.isEditable = false
        outputTextView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.8)
        outputTextView.text = ""
        outputTextView.textColor = .black
        outputTextView.font = UIFont.boldSystemFont(ofSize: 30)
        outputTextView.isUserInteractionEnabled = true
        outputTextView.autocorrectionType = .no
    }

    ///Invokes audio engine to speak the text on output text view
    func speak() {
        DispatchQueue.main.async {
            let utterance = AVSpeechUtterance(string: self.outputTextView.text!)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = 0.4 + (self.speechSpeedDegree/500)
            print("utterance rate: \(utterance)")
            self.synthesizer = AVSpeechSynthesizer()
            self.synthesizer.speak(utterance)
        }
    }

    // MARK: Control View
    ///Setup position/size/style of the speak button holder and add it on screen
    func speakerButtonSetup() {

        speakerButton.backgroundColor = .systemOrange
        speakerButton.setTitle("Speak", for: .normal)
        speakerButton.setTitle("Mute", for: .selected)
        speakerButton.addTarget(self, action: #selector(speakerButtonTapped), for: .touchUpInside)
    }

    ///Action invoked when speaker button tapped. Asks audio engine to play the speech generated from text
    @objc func speakerButtonTapped() {
        if speakerButton.isSelected {
            speakerButton.isSelected = false
            speakerButton.backgroundColor = .systemOrange
            synthesizer.stopSpeaking(at: .word)
        } else {
            speakerButton.isSelected = true
            speak()
            speakerButton.backgroundColor = .systemRed
        }
    }

    ///Setup position/size/style of the  train button and add it on screen
    func trainButtonSetup() {
        controlView.addSubview(trainButton)
        trainButton.translatesAutoresizingMaskIntoConstraints = false
        trainButton.leadingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: 10).isActive = true
        trainButton.trailingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: -10).isActive = true
        trainButton.topAnchor.constraint(equalTo: controlButtonStack.bottomAnchor, constant: 20).isActive = true
        trainButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        trainButton.setTitle("Help Us Learn ASL", for: .normal)
        trainButton.setTitleColor(.black, for: .normal)
        trainButton.layer.cornerRadius = 10
        trainButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        trainButton.backgroundColor = .systemYellow
    }

    ///Setup position/size/style of the clear button and add it on screen
    func clearButtonSetup() {

        clearButton.backgroundColor = .systemRed
        clearButton.setTitle("Clear", for: .normal)
        clearButton.isSelected = true
        clearButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        clearButton.layer.cornerRadius = 10
        clearButton.clipsToBounds = true
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }

    ///Action invoked when clear button is tapped. Clearns the output text view
    @objc func clearButtonTapped() {
        outputTextView.text.removeAll()
    }

    ///Setup position/size/style of the  control button stack and add it on screen
    func controlButtonStackSetup() {
        controlView.addSubview(controlButtonStack)
        controlButtonStack.translatesAutoresizingMaskIntoConstraints = false
        controlButtonStack.leadingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: 5).isActive = true
        controlButtonStack.trailingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: -5).isActive = true
        controlButtonStack.topAnchor.constraint(equalTo: controlView.topAnchor, constant: 5).isActive = true
        controlButtonStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        controlButtonStack.addArrangedSubview(controlButton)
        controlButtonStack.addArrangedSubview(keyboardButton)
        controlButtonStack.addArrangedSubview(speakerButton)
        controlButtonStack.addArrangedSubview(clearButton)
        controlButtonStack.distribution = .fillEqually
        controlButtonStack.spacing = 2
        controlButtonStack.layer.cornerRadius = 10
    }

    ///Setup position/size/style of the keyboard button and add it on screen
    func keyboardButtonSetup() {

        keyboardButton.backgroundColor = .systemOrange
        keyboardButton.setTitle("Keyboard", for: .normal)
        keyboardButton.isSelected = true
        keyboardButton.addTarget(self, action: #selector(keyboardButtonTapped), for: .touchUpInside)
    }

    ///Action for when keyboard button is tapped, raises the view, activates output text view to edit and present the keyboard.
    @objc func keyboardButtonTapped() {
        textViewHolder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        if keyboardButton.isSelected {
            keyboardButton.isSelected = false
            print("switched to keyboard mode")
            keyboardButton.setTitle("ASL", for: .normal)
            outputTextView.isEditable = true
            outputTextView.becomeFirstResponder()
            outputTextView.backgroundColor = .white
            UIView.animate(withDuration: 0.2) {
                self.controlButton.isHidden = true
                self.keyboardButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                self.keyboardButton.layer.cornerRadius = 10
            }
        } else {
            print("switched to ASL mode")
            keyboardButton.isSelected = true
            keyboardButton.setTitle("Keyboard", for: .normal)
            outputTextView.isEditable = false
            outputTextView.resignFirstResponder()
            outputTextView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.6)
            textViewHolder.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.6)
            UIView.animate(withDuration: 0.2) {
                self.controlButton.isHidden = false
                self.keyboardButton.layer.cornerRadius = 0
            }
            dismissKeyboard()
        }
    }

    ///Setup position/size/style of the dash board and add it on screen
    func controlViewSetup() {
        view.addSubview(controlView)
        controlView.translatesAutoresizingMaskIntoConstraints = false
        controlViewHeightAnchor = controlView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -54)
        controlView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        controlView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        controlView.heightAnchor.constraint(equalToConstant: view.frame.size.height/2).isActive = true
        controlViewHeightAnchor.isActive = true
        controlView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        controlView.clipsToBounds = true
        controlView.backgroundColor = .white
        controlView.isUserInteractionEnabled = true
    }

    ///Setup position/size/style of the control button and add it on screen
    func controlButtonSetup() {
        controlButton.backgroundColor = .systemBlue
        controlButton.setTitle("More", for: .normal)
        controlButton.setTitle("Close Dashboard", for: .selected)
        controlButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        controlButton.layer.cornerRadius = 10
        controlButton.clipsToBounds = true
        controlButton.addTarget(self, action: #selector(controlButtonTapped(_:)), for: .touchUpInside)
    }

    ///Action for control button when tapped. Expands or collaps the dash button
    @objc func controlButtonTapped(_ sender: UIButton) {
        textViewHolder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        if sender.isSelected {
            sender.isSelected = false
            UIView.animate(withDuration: 0.2, animations: {
                self.controlViewHeightAnchor.constant = -54
                self.keyboardButton.isHidden = false
                self.clearButton.isHidden = false
                self.speakerButton.isHidden = false
                self.controlButton.layer.maskedCorners = [ .layerMinXMinYCorner, .layerMinXMaxYCorner]
                self.controlButton.layer.cornerRadius = 10
                self.view.layoutIfNeeded()
            })
        } else {
            sender.isSelected = true
            UIView.animate(withDuration: 0.2, animations: {
                self.controlViewHeightAnchor.constant = -self.view.frame.size.height/2
                self.keyboardButton.isHidden = true
                self.clearButton.isHidden = true
                self.speakerButton.isHidden = true
                self.controlButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
                self.view.layoutIfNeeded()
            })
        }

    }

    ///Setup position/size/style of the log out button and add it on screen
    func logOutButtonSetup() {
        controlView.addSubview(logOutButton)
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.topAnchor.constraint(equalTo: trainButton.bottomAnchor, constant: 20).isActive = true
        logOutButton.leadingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: 10).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: -10).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logOutButton.setTitle("Log out", for: .normal)
        logOutButton.backgroundColor = .systemRed
        logOutButton.layer.cornerRadius = 10
        logOutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        if userIsLoggedOut() {
            logOutButton.isEnabled = false
            logOutButton.alpha = 0.2
        } else {
            logOutButton.isEnabled = true
            logOutButton.alpha = 1
        }
    }
    
    @objc func handleLogout() {

        print("handle logout tapped")

        //log the user out of firebase
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }

        //remove keys from keychain
        keychain.clear()

        //present the login screen
        let loginController = LoginVC()
        loginController.modalTransitionStyle = .crossDissolve
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: nil)
    }

    ///Setup prediction assist button's location/size/styling and add on screen
    func predictionAssistButtonSetup() {
        controlView.addSubview(predictionAssistButton)
        predictionAssistButton.translatesAutoresizingMaskIntoConstraints = false
        predictionAssistButton.topAnchor.constraint(equalTo: logOutButton.bottomAnchor, constant: 20).isActive = true
        predictionAssistButton.leadingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: 10).isActive = true
        predictionAssistButton.trailingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: -10).isActive = true
        predictionAssistButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        predictionAssistButton.setTitle("Prediction Assist: on", for: .selected)
        predictionAssistButton.setTitle("Prediction Assist: off", for: .normal)
        predictionAssistButton.backgroundColor = .systemGreen
        predictionAssistButton.isSelected = true
        predictionAssistButton.layer.cornerRadius = 10
        predictionAssistButton.addTarget(self, action: #selector(predictionAssistButtonTapped), for: .touchUpInside)
    }

    ///Action for prediction button tapped. Enables Prediction algorithm to help the ASL
    @objc func predictionAssistButtonTapped() {
        if predictionAssistButton.isSelected {
            predictionAssistButton.isSelected = false
            predictionAssistButton.backgroundColor = .systemGray
        } else {
            predictionAssistButton.isSelected = true
            predictionAssistButton.backgroundColor = .systemGreen
        }
    }

    ///Setup position/size/style of the speech speed slider and add it on screen
    func sliderSetup() {
        controlView.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.leadingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: 20).isActive = true
        slider.trailingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: -20).isActive = true
        slider.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: -20).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 20).isActive = true
        slider.center = self.view.center

        slider.minimumTrackTintColor = .black
        slider.maximumTrackTintColor = .black
        slider.thumbTintColor = .systemOrange

        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.setValue(50, animated: false)

        slider.addTarget(self, action: #selector(changeValue(_:)), for: .valueChanged)

    }

    ///Action that listens to value chage and sets the speed for the voice utterance
    @objc func changeValue(_ sender: UISlider) {
        print("value is", Int(sender.value))
        speechSpeedDegree = sender.value
    }
    
    ///Setup position/size/style of the area bound and add it on screen
    func areaBoundSetup(){
        previewView.addSubview(areaBound)
        areaBound.translatesAutoresizingMaskIntoConstraints = false
        areaBound.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        areaBound.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        areaBound.widthAnchor.constraint(equalToConstant: view.frame.size.width-10).isActive = true
        areaBound.heightAnchor.constraint(equalToConstant: view.frame.size.width-10).isActive = true
        areaBound.layer.borderWidth = 2
        areaBound.layer.borderColor = UIColor.red.cgColor
        
        let textView = UILabel()
        areaBound.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: areaBound.topAnchor, constant: 2).isActive = true
        textView.leadingAnchor.constraint(equalTo: areaBound.leadingAnchor, constant: 2).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        textView.text = "Nothing Detected"
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.textColor = .red
    }


}
extension ViewController {
    ///delete character from the output text veiw
	func deleteCharacter() {
		DispatchQueue.main.async {
            if self.outputTextView.text != "" {
				var text = self.outputTextView.text
                text?.removeLast()
                self.outputTextView.text = text
            }
		}
	}
    
    ///add space to the output textview
	func addSpace() {
		DispatchQueue.main.async {
            if self.outputTextView.text != "" {
				var text = self.outputTextView.text
                text?.append(" ")
                self.outputTextView.text = text
            }
		}
	}

    ///Update the outpute view with the latest result from the model and add necessary spaces or delete character. Also invokes prediction layer to assist with the asl to text
	func executeASLtoText() {
		switch result?.inferences[0].label {
		case "del":
            DispatchQueue.main.async {
                self.areaBound.isHidden = true
            }
			deleteCharacter()
		case "space":
            DispatchQueue.main.async {
                self.areaBound.isHidden = true
            }
			addSpace()
            speak()
		case "nothing":
            if true {}
		default:

			DispatchQueue.main.async {
                self.areaBound.isHidden = true
				let confidence = self.result!.inferences[0].confidence
				let prediction: String = self.result!.inferences[0].label.description
                print("actual \(prediction) output \(self.predictionLayer.letterProximitySwap(inputChar: prediction))")
                self.outputTextView.text.append(self.predictionLayer.letterProximitySwap(inputChar: prediction))
			}
		}
		
	}
}


