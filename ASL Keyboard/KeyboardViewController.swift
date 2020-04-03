//
//  KeyboardViewController.swift
//  ASL Keyboard
//
//  Created by Likhon Gomes on 3/20/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    let previewView = PreviewView()
    let keyboardView = UIView()

    override func updateViewConstraints() {
        super.updateViewConstraints()

        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)

        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false

        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)

        self.view.addSubview(self.nextKeyboardButton)

        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        self.view.addSubview(previewView)
        self.previewView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //self.previewView.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.previewView.topAnchor.constraint(equalTo: view.topAnchor),
            self.previewView.widthAnchor.constraint(equalToConstant: 150),
            self.previewView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //self.previewView.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
          ])
        self.previewView.backgroundColor = .blue
    }

    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.

        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

    func previewViewSetup() {
        view.addSubview(previewView)
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        previewView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        //previewView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        //previewView.trailingAnchor.constraint(equalTo: caboardView.trailingAnchor).isActive = true
        previewView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        previewView.backgroundColor = .black
    }

}
