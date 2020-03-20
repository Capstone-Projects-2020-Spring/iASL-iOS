//
//  SpeechToTextVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/17/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Speech

class SpeechToTextVC: UIViewController, SFSpeechRecognizerDelegate {

    
    
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    let textView = UITextView()
    let liveButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        liveButtonSetup()
        textViewSetup()
        print("adsf")
        speechRecognizer.delegate = self
        
         record()
        
        
        // Asynchronously make the authorization request.
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
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
            
            //record()
        }
        
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
            print("adsf")
            dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
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
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        // Let the user know to start talking.
        textView.text = "(Go ahead, I'm listening)"
    }
    
    
    // MARK: SFSpeechRecognizerDelegate
    
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

    func textViewSetup(){
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
    
    func liveButtonSetup(){
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
    
    @objc func liveButtonTapped() {
        audioEngine.stop()
        dismiss(animated: true, completion: nil)
    }
    
}
