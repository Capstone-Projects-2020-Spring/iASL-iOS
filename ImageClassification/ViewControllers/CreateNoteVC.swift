//
//  CreateNoteVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/10/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class CreateNoteVC: UIViewController {

    let backButton = UIButton()
    let textView = UITextView()
    let noteTitle = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        backButtonSetup()
        noteTitleSetup()
        textViewSetup()

    }

}

extension CreateNoteVC {

    func backButtonSetup() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.backgroundColor = .red
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    func noteTitleSetup() {
        view.addSubview(noteTitle)
        noteTitle.translatesAutoresizingMaskIntoConstraints = false
        noteTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        noteTitle.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10).isActive = true
        noteTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        noteTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        noteTitle.font = UIFont.boldSystemFont(ofSize: 30)
    }

    func textViewSetup() {
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: noteTitle.bottomAnchor, constant: 5).isActive = true
        textView.font = UIFont.systemFont(ofSize: 20)
    }

}
