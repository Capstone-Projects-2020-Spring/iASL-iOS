//
//  Caboard.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/20/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class Caboard: UIViewController {

    let caboardView = UIView()
    let previewView = PreviewView()
    let composedMessage = UITextView()
    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        caboardViewSetup()
        previewViewSetup()
        nextButtonSetup()
        //composedMessageSetup()
    }

}

extension Caboard {

    func caboardViewSetup() {
        view.addSubview(caboardView)
        caboardView.translatesAutoresizingMaskIntoConstraints = false
        caboardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        caboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        caboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        caboardView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        caboardView.backgroundColor = .white
    }

    func previewViewSetup() {
        caboardView.addSubview(previewView)
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        previewView.topAnchor.constraint(equalTo: caboardView.topAnchor, constant: 5).isActive = true
        //previewView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        //previewView.trailingAnchor.constraint(equalTo: caboardView.trailingAnchor).isActive = true
        previewView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: caboardView.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        previewView.backgroundColor = .black
    }

    func nextButtonSetup() {
        caboardView.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: caboardView.trailingAnchor, constant: -5).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: caboardView.bottomAnchor, constant: -5).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.backgroundColor = #colorLiteral(red: 0.1800611732, green: 0.3206211665, blue: 0.7568627596, alpha: 1)
        nextButton.setTitle("Next", for: .normal)
        nextButton.layer.cornerRadius = 5
    }

}
