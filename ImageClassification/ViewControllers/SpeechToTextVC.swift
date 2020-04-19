//
//  SpeechToTextVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/17/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Speech

///View Controller to handle speech to text and show it on screen, Invoked by button press or device orientation change. This class handles both recording and and turns the recorded sound to text via transcription
class SpeechToTextVC: UIViewController, SFSpeechRecognizerDelegate {

    ///Speech recognier to activate speech to text
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    ///request to OS to start recognition
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    ///Task that handles recognitions
    private var recognitionTask: SFSpeechRecognitionTask?
    ///Audio engine to play back the text to speech
    private let audioEngine = AVAudioEngine()
    ///Textview to show texts recorder and transcribed from mictrophone
    let textView = UITextView()
    ///Button to go back to the ASL View Controller
    let liveButton = UIButton()

    ///Main function to call all the necessary UI and backend code
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        liveButtonSetup()
        textViewSetup()
        print("adsf")
        speechRecognizer.delegate = self

         record()
        /// Asynchronously make the authorization request.
        SFSpeechRecognizer.requestAuthorization { authStatus in
            // Divert to the app's main thread so that the UI
            // can be updated.
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.liveButton.isEnabled = true
                case .denied:
                    self.liveButton.isEnabled = false
                    self.liveButton.setTitle("User denied access to speech recognition", for: .disabled)
                case .restricted:
                    self.liveButton.isEnabled = false
                    self.liveButton.setTitle("Speech recognition restricted on this device", for: .disabled)
                case .notDetermined:
                    self.liveButton.isEnabled = false
                    self.liveButton.setTitle("Speech recognition not yet authorized", for: .disabled)
                default:
                    self.liveButton.isEnabled = false
                }
            }
        }
    }

    ///Detect orientation change and if Upside down from current orientation then go back to the ASL view controller
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {

            //record()
        }

        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
            print("adsf")
            dismiss(animated: true, completion: nil)
        }

    }

    ///Letting the OS know the type of orientations supported by this view controller
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }

    ///Let the OS know what to do when the view appears
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    ///Start recording and output the result on the textview
    private func startRecording() throws {

        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil

        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode

        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true

        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }

        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false

            if let result = result {
                // Update the text view with the results.
                self.textView.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
                print("Text \(result.bestTranscription.formattedString)")
            }

            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.liveButton.isEnabled = true
                self.liveButton.setTitle("Start Recording", for: [])
            }
        }

        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, _: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()

        // Let the user know to start talking.
        textView.text = "(Go ahead, I'm listening)"
    }

    // MARK: SFSpeechRecognizerDelegate
    ///Recognize the speech and transcribe it
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            liveButton.isEnabled = true
            liveButton.setTitle("Start Recording", for: [])
        } else {
            liveButton.isEnabled = false
            liveButton.setTitle("Recognition Not Available", for: .disabled)
        }
    }

}

extension SpeechToTextVC {
    ///Start recording
    func record() {
        print("tapped")
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            liveButton.isEnabled = false
            liveButton.setTitle("Stopping", for: .disabled)
        } else {
            do {
                try startRecording()
                liveButton.setTitle("Stop Recording", for: [])
            } catch {
                liveButton.setTitle("Recording Not Available", for: [])
            }
        }
    }

    // MARK: Interface Builder actions
    ///Setup text view to show transcriptions done from microphone
    func textViewSetup() {
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView.topAnchor.constraint(equalTo: liveButton.bottomAnchor, constant: 10).isActive = true
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = UIFont.boldSystemFont(ofSize: 30)
    }

    ///Setup the ASL button to go back to ASL view controller
    func liveButtonSetup() {
        view.addSubview(liveButton)
        liveButton.translatesAutoresizingMaskIntoConstraints = false
        //liveButton.setTitle("Live", for: .normal)
        liveButton.setImage(#imageLiteral(resourceName: "microphone"), for: .normal)
        liveButton.setImage(#imageLiteral(resourceName: "microphone"), for: .selected)
        liveButton.imageView?.contentMode = .scaleAspectFit
        liveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        liveButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        liveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        liveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        liveButton.addTarget(self, action: #selector(liveButtonTapped), for: .touchUpInside)
    }
    
    ///Action to go back to the asl view controller
    @objc func liveButtonTapped() {
        audioEngine.stop()
        dismiss(animated: true, completion: nil)
    }

}
