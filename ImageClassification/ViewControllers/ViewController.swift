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

class ViewController: UIViewController {

    let remoteChatButton = UIButton()
    let liveChatButton = UIButton()
    let notesButton = UIButton()
    let buttonStack = UIStackView()
    let liveButton = UIButton()
    let tabController = UITabBarController()
    let outputTextView = UITextView()
    let textViewHolder = UIView()

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    let notes = NotesVC()

    let logoLabel = UILabel()
    let topBar = UIView()
    // MARK: Storyboards Connections
    @IBOutlet weak var previewView: PreviewView!
    let cameraUnavailableLabel = UILabel()
    let resumeButton = UIButton()
    @IBOutlet weak var bottomSheetView: CurvedView!

    @IBOutlet weak var bottomSheetViewBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var bottomSheetStateImageView: UIImageView!
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
    private var inferenceViewController = InferenceViewController()

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
        //previewViewSetup()

        print("we loaded the main view controller")

        topBarSetup()
        //logoLabelSetup()
        cameraUnavailableLabelSetup()
        notesButtonSetup()
        remoteChatButtonSetup()
        resumeButtonSetup()
        liveButtonSetup()
        textViewHolderSetup()
        outputTextViewSetup()
        //speak()

        //liveButton

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

        addPanGesture()
    }

    func tabBarControllerSetup() {

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        changeBottomViewState()

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

            inferenceViewController = (segue.destination as? InferenceViewController)!
            inferenceViewController.wantedInputHeight = tempModelDataHandler.inputHeight
            inferenceViewController.wantedInputWidth = tempModelDataHandler.inputWidth
            inferenceViewController.maxResults = tempModelDataHandler.resultCount
            inferenceViewController.threadCountLimit = tempModelDataHandler.threadCountLimit
            inferenceViewController.delegate = self

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

// MARK: InferenceViewControllerDelegate Methods
extension ViewController: InferenceViewControllerDelegate {

    func didChangeThreadCount(to count: Int) {
        if modelDataHandler?.threadCount == count { return }
        modelDataHandler = ModelDataHandler(
            modelFileInfo: MobileNet.modelInfo,
            labelsFileInfo: MobileNet.labelsInfo,
            threadCount: count
        )
    }
}

// MARK: CameraFeedManagerDelegate Methods
extension ViewController: CameraFeedManagerDelegate {

	fileprivate func deleteCharacter() {
		DispatchQueue.main.async {
            if self.outputTextView.text != "" {
                var text = self.outputTextView.text
                text?.removeLast()
                self.outputTextView.text = text
            }
		}
	}

	func didOutput(pixelBuffer: CVPixelBuffer) {
        let currentTimeMs = Date().timeIntervalSince1970 * 1000
        guard (currentTimeMs - previousInferenceTimeMs) >= delayBetweenInferencesMs else { return }
        previousInferenceTimeMs = currentTimeMs

        // Pass the pixel buffer to TensorFlow Lite to perform inference.
        result = modelDataHandler?.runModel(onFrame: pixelBuffer)
		switch result?.inferences[0].label {
		case "del":
			deleteCharacter()
		case "space":
			print("space")
		default:
			DispatchQueue.main.async {
				self.outputTextView.text += self.result!.inferences[0].label.description
			}
		}
        // Display results by handing off to the InferenceViewController.
        DispatchQueue.main.async {
            let resolution = CGSize(width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            self.inferenceViewController.inferenceResult = self.result
            self.inferenceViewController.resolution = resolution
            self.inferenceViewController.tableView.reloadData()
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

// MARK: Bottom Sheet Interaction Methods
extension ViewController {

    // MARK: Bottom Sheet Interaction Methods
    /**
     This method adds a pan gesture to make the bottom sheet interactive.
     */
    private func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.didPan(panGesture:)))
        bottomSheetView.addGestureRecognizer(panGesture)
    }

    /** Change whether bottom sheet should be in expanded or collapsed state.
     */
    private func changeBottomViewState() {

        let inferenceVC = inferenceViewController

        if bottomSheetViewBottomSpace.constant == inferenceVC.collapsedHeight - bottomSheetView.bounds.size.height {

            bottomSheetViewBottomSpace.constant = 0.0
        } else {
            bottomSheetViewBottomSpace.constant = inferenceVC.collapsedHeight - bottomSheetView.bounds.size.height
        }
        setImageBasedOnBottomViewState()
    }

    /**
     Set image of the bottom sheet icon based on whether it is expanded or collapsed
     */
    private func setImageBasedOnBottomViewState() {

        if bottomSheetViewBottomSpace.constant == 0.0 {
            bottomSheetStateImageView.image = UIImage(named: "down_icon")
        } else {
            bottomSheetStateImageView.image = UIImage(named: "up_icon")
        }
    }

    /**
     This method responds to the user panning on the bottom sheet.
     */
    @objc func didPan(panGesture: UIPanGestureRecognizer) {

        // Opens or closes the bottom sheet based on the user's interaction with the bottom sheet.
        let translation = panGesture.translation(in: view)

        switch panGesture.state {
        case .began:
            initialBottomSpace = bottomSheetViewBottomSpace.constant
            translateBottomSheet(withVerticalTranslation: translation.y)
        case .changed:
            translateBottomSheet(withVerticalTranslation: translation.y)
        case .cancelled:
            setBottomSheetLayout(withBottomSpace: initialBottomSpace)
        case .ended:
            translateBottomSheetAtEndOfPan(withVerticalTranslation: translation.y)
            setImageBasedOnBottomViewState()
            initialBottomSpace = 0.0
        default:
            break
        }
    }

    /**
     This method sets bottom sheet translation while pan gesture state is continuously changing.
     */
    private func translateBottomSheet(withVerticalTranslation verticalTranslation: CGFloat) {

        let bottomSpace = initialBottomSpace - verticalTranslation
        guard bottomSpace <= 0.0 && bottomSpace >= inferenceViewController.collapsedHeight - bottomSheetView.bounds.size.height else {
            return
        }
        setBottomSheetLayout(withBottomSpace: bottomSpace)
    }

    /**
     This method changes bottom sheet state to either fully expanded or closed at the end of pan.
     */
    private func translateBottomSheetAtEndOfPan(withVerticalTranslation verticalTranslation: CGFloat) {

        // Changes bottom sheet state to either fully open or closed at the end of pan.
        let bottomSpace = bottomSpaceAtEndOfPan(withVerticalTranslation: verticalTranslation)
        setBottomSheetLayout(withBottomSpace: bottomSpace)
    }

    /**
     Return the final state of the bottom sheet view (whether fully collapsed or expanded) that is to be retained.
     */
    private func bottomSpaceAtEndOfPan(withVerticalTranslation verticalTranslation: CGFloat) -> CGFloat {

        // Calculates whether to fully expand or collapse bottom sheet when pan gesture ends.
        var bottomSpace = initialBottomSpace - verticalTranslation

        var height: CGFloat = 0.0
        if initialBottomSpace == 0.0 {
            height = bottomSheetView.bounds.size.height
        } else {
            height = inferenceViewController.collapsedHeight
        }

        let currentHeight = bottomSheetView.bounds.size.height + bottomSpace

        if currentHeight - height <= collapseTransitionThreshold {
            bottomSpace = inferenceViewController.collapsedHeight - bottomSheetView.bounds.size.height
        } else if currentHeight - height >= expandThransitionThreshold {
            bottomSpace = 0.0
        } else {
            bottomSpace = initialBottomSpace
        }

        return bottomSpace
    }

    /**
     This method layouts the change of the bottom space of bottom sheet with respect to the view managed by this controller.
     */
    func setBottomSheetLayout(withBottomSpace bottomSpace: CGFloat) {

        view.setNeedsLayout()
        bottomSheetViewBottomSpace.constant = bottomSpace
        view.setNeedsLayout()
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

        func logoLabelSetup() {
            topBar.addSubview(logoLabel)
            logoLabel.translatesAutoresizingMaskIntoConstraints = false
            logoLabel.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -10).isActive = true
            logoLabel.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 40).isActive = true
            logoLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            logoLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
            logoLabel.text = "iASL"
            logoLabel.font = UIFont.systemFont(ofSize: 30)
            logoLabel.textColor = .white
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

        @objc func notesButtonTapped() {
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
            textViewHolder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            textViewHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            textViewHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            textViewHolder.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
            textViewHolder.backgroundColor = #colorLiteral(red: 0.9596421632, green: 0.9596421632, blue: 0.9596421632, alpha: 1)
            textViewHolder.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            textViewHolder.layer.cornerRadius = 20
        }

        func outputTextViewSetup() {
            view.addSubview(outputTextView)
            outputTextView.translatesAutoresizingMaskIntoConstraints = false
            outputTextView.bottomAnchor.constraint(equalTo: textViewHolder.bottomAnchor).isActive = true
            outputTextView.leadingAnchor.constraint(equalTo: textViewHolder.leadingAnchor).isActive = true
            outputTextView.trailingAnchor.constraint(equalTo: textViewHolder.trailingAnchor).isActive = true
            outputTextView.topAnchor.constraint(equalTo: textViewHolder.topAnchor, constant: 20).isActive = true
            outputTextView.isEditable = false
            outputTextView.text = ""
            outputTextView.textColor = .gray
            outputTextView.font = UIFont.boldSystemFont(ofSize: 30)
        }

        func speak() {
            let utterance = AVSpeechUtterance(string: outputTextView.text!)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = 0.4

            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
        }

}
