//
//  CreateNoteVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/10/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Firebase

class CreateNoteVC: UIViewController {
    
    //this is the note that will be set from the NotesVC
    var note: Note?
    
    //this is where the note to be updated can be found in firebase
    var noteToUpdateKey: String?
    
    let notesConstant: String = "notes"
    let userNotesConstant: String = "user-notes"

    let backButton = UIButton()
    let textView = UITextView()
    let noteTitle = UITextField()
    
    ///save button for saving notes
    let saveButton: UIButton = {
        let save = UIButton()
        save.backgroundColor = .clear
        save.setTitle("Save", for: .normal)
        save.setTitleColor(.systemPink, for: .normal)
        save.translatesAutoresizingMaskIntoConstraints = false
        save.titleLabel?.font = .boldSystemFont(ofSize: 30)
        save.addTarget(self, action: #selector(handleSaveNote), for: .touchUpInside)
        return save
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSaveNoteButton()
        backButtonSetup()
        noteTitleSetup()
        textViewSetup()
        loadNote()
    }
    
    ///if the note already exists, loads the contents into the VC
    func loadNote() {
        noteTitle.text = note?.title
        textView.text = note?.text
    }
    
    ///handles what happens when a note is saved
    @objc func handleSaveNote() {
        print("save note button pressed")
        //print("Here is the note: ", textView.text!)
        
        //two cases: new note created and old note needs to be updated
        if note == nil {
            let newNote = Note()
            note = newNote
            handleNewNote()
            dismiss(animated: true, completion: nil)
        } else {
            handleUpdateNote()
        }
        
    }
    
    ///handles what happens when a new note is made
    func handleNewNote() {
        
        print("handle new note")
        toggleSaveButtonDisabled()
        

        //need to save a message here, just like with messaging
        guard let noteText = textView.text, let title = noteTitle.text else {
            print("could not get message")
            return
        }


        let ref = Database.database().reference().child(self.notesConstant)
        //gets an auto ID for each message
        let childRef = ref.childByAutoId()

        //owner is the owner id of the note
        guard let owner = Auth.auth().currentUser?.uid else {
            print("could not get necessary message information")
            return
        }

        //gets it in milliseconds
        let timestamp: NSNumber = NSNumber(value: NSDate().timeIntervalSince1970 * 1000)

        let values = ["id": childRef.key!, "title": title, "text": noteText, "timestamp": timestamp, "ownerId": owner] as [String: Any]

        childRef.updateChildValues(values) { (error, _) in
            if error != nil {
                print(error!)
                return
            }

            //you've added your message successfully\
            print("successfully added the note to the notes node")

            //need to also save to new node for cost related issues
            let userNotesRef = Database.database().reference().child(self.userNotesConstant).child(owner)

            let noteId = childRef.key
            let userValue = [noteId: 1] as! [String: Any]

            userNotesRef.updateChildValues(userValue) { (error2, _) in
                if error2 != nil {
                    print(error2!)
                    return
                }

                //you've added to the user-messages node for message senders
                print("you've added to the user-notes node for owners")
            }

        }
    }
    
    ///need to be able to overwrite an existing note
    func handleUpdateNote() {
        print("handle update note")
        toggleSaveButtonDisabled()
        
        
        //need to save a message here, just like with messaging
        guard let noteText = textView.text, let title = noteTitle.text else {
            print("could not get message")
            return
        }
        
        //owner is the owner id of the note
        guard let owner = Auth.auth().currentUser?.uid else {
            print("could not get necessary message information")
            return
        }
        
        guard let key = self.noteToUpdateKey else {
            return
        }
        
        let ref = Database.database().reference().child(self.notesConstant)
        //gets an auto ID for each message
        let childRef = ref.child(key)
        
        //gets it in milliseconds
        let timestamp: NSNumber = NSNumber(value: NSDate().timeIntervalSince1970 * 1000)
        
        let values = ["id": childRef.key!,"title": title, "text": noteText, "timestamp": timestamp, "ownerId": owner] as [String: Any]
        
        childRef.updateChildValues(values) { (error, _) in
            if error != nil {
                print(error!)
                return
            }

            //you've updated your note successfully
            print("successfully updated the note in the notes node")
        }

        
        
        
        
        
    }
    
    ///handles the constraints and set up of the save button
    func setupSaveNoteButton() {
        view.addSubview(saveButton)
        
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        //saveButton.widthAnchor.constraint(equalTo: noteTitle.widthAnchor).isActive = true
        
        toggleSaveButtonEnabled()
    }
    
    ///sets the save button to enabled and makes the color normal
    func toggleSaveButtonEnabled() {
        saveButton.isEnabled = true
        saveButton.alpha = 1
    }
    
    ///sets the save button to disabled and makes the color of the bottom dim
    func toggleSaveButtonDisabled() {
        saveButton.isEnabled = false
        saveButton.alpha = 0.2
    }

}

extension CreateNoteVC: UITextViewDelegate {

    ///set up for the back button
    func backButtonSetup() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        let tintedImage = #imageLiteral(resourceName: "back").withRenderingMode(.alwaysTemplate)
        backButton.setImage(tintedImage, for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    ///what happens when the back button is tapped, dismisses the view controller
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    ///sets up the note title
    func noteTitleSetup() {
        view.addSubview(noteTitle)
        noteTitle.translatesAutoresizingMaskIntoConstraints = false
        noteTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        noteTitle.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10).isActive = true
        noteTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        noteTitle.rightAnchor.constraint(equalTo: saveButton.leftAnchor, constant: -10).isActive = true
        noteTitle.font = UIFont.boldSystemFont(ofSize: 30)
    }

    ///sets up the main text view
    func textViewSetup() {
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: noteTitle.bottomAnchor, constant: 5).isActive = true
        textView.font = UIFont.systemFont(ofSize: 20)
		textView.inputView = Caboard(target: textView)
        
        textView.delegate = self
    }
    
    ///if the text changed in the view controller, toggle the save button 
    func textViewDidChange(_ textView: UITextView) {
        print("textview did change")
        toggleSaveButtonEnabled()
    }

}
