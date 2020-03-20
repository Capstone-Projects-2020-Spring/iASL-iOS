//
//  TranscribeVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/19/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class TranscribeVC: UIViewController {

    let textView = UITextView()
    let liveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        liveButtonSetup()
        textViewSetup()
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TranscribeVC {

//    func record() {
//        print("tapped")
//        if audioEngine.isRunning {
//            audioEngine.stop()
//            recognitionRequest?.endAudio()
//            liveButton.isEnabled = false
//            liveButton.setTitle("Stopping", for: .disabled)
//        } else {
//            do {
//                try startRecording()
//                liveButton.setTitle("Stop Recording", for: [])
//            } catch {
//                liveButton.setTitle("Recording Not Available", for: [])
//            }
//        }
//    }

    // MARK: Interface Builder actions

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

    @objc func liveButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}
