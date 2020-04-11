//
//  CreateNoteVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/10/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Firebase
import KMPlaceholderTextView

class CreateNoteVC: UIViewController {
    
    //this is the note that will be set from the NotesVC
    var note: Note?
    
    //this is where the note to be updated can be found in firebase
    var noteToUpdateKey: String?
    
    let notesConstant: String = "notes"
    let userNotesConstant: String = "user-notes"
    
    let backButton = UIButton()
    let textView = KMPlaceholderTextView()
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
    

    
    ///if the note already exists, loads the contents into the VC. if it does not exist, set placeholders
    func loadNote() {
        
        toggleSaveButtonDisabled()
        
        if note == nil {
            noteTitle.placeholder = "Title"
            textView.placeholder = "Type note here..."

        } else {
            noteTitle.text = note?.title
            textView.text = note?.text
        }
    }




    
    ///handles what happens when a note is saved
    @objc func handleSaveNote() {
        print("save note button pressed")
        //print("Here is the note: ", textView.text!)
        
        //two cases: new note created and old note needs to be updated
        if note == nil {
            let newNote = Note()
            newNote.title = "Title"
            note = newNote
            handleNewNote()
            
            dismiss(animated: true, completion: { () in
                print("completion handler new note")
                //self.NotesVC?.notes.removeAll()
                //self.NotesVC?.observeUserNotes()
                //self.NotesVC?.tableView.reloadData()
                
            })
        } else {
            handleUpdateNote()
//            self.NotesVC?.notes.removeAll()
//            self.NotesVC?.tableView.reloadData()
//            self.NotesVC?.observeUserNotes()
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

        //get a reference ot the database at the "notes" node
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

        //values to be added to the new node
        let values = ["id": childRef.key!, "title": title, "text": noteText, "timestamp": timestamp, "ownerId": owner] as [String: Any]

        //add the values to the node
        childRef.updateChildValues(values) { (error, _) in
            if error != nil {
                print(error!)
                return
            }
            //you've added your message successfully\
            print("successfully added the note to the notes node")
            //need to also save to new node for cost related issues
            //only looks at user-notes->ownerID
            let userNotesRef = Database.database().reference().child(self.userNotesConstant).child(owner)
            //this is for a different root node
            let noteId = childRef.key
            //value to be entered into the "user-notes" node
            //there will be one of these for each note PER user
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
        
        //key is the node at which we are updating the note
        guard let key = self.noteToUpdateKey else {
            return
        }
        
        //gets a reference to the database at the "notes" node
        let ref = Database.database().reference().child(self.notesConstant)
        //gets an auto ID for each note
        let childRef = ref.child(key)
        
        //gets it in milliseconds
        let timestamp: NSNumber = NSNumber(value: NSDate().timeIntervalSince1970 * 1000)
        
        //values to be inserted into the node
        let values = ["id": childRef.key!, "title": title, "text": noteText, "timestamp": timestamp, "ownerId": owner] as [String: Any]
        
        //update the node with the values we just defined above
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

extension CreateNoteVC: UITextViewDelegate, UITextFieldDelegate {

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
        
        //need to check if user has changed their note and not saved
        if saveButton.isEnabled {
            print("save button enabled")
            
            let saveResponse = UIAlertAction(title: "Save", style: .default) { (action) in
                //respond to user selection of action
                print("save pressed")
                self.handleSaveNote()
                self.dismiss(animated: true, completion: nil)
            }
            
            let doNotSaveResponse = UIAlertAction(title: "Remove changes", style: .default) { (action) in
                //respond to user selection
                print("remove changes pressed")
                self.dismiss(animated: true, completion: nil)
            }
            
            let alert = UIAlertController(title: "You have not saved changes!", message: "Are you sure you want to leave?", preferredStyle: .alert)
            alert.addAction(saveResponse)
            alert.addAction(doNotSaveResponse)
            
            self.present(alert, animated: true) {
                //alert was presented
            }
            
        } else {
            
            //this is where the back button is tapped
            dismiss(animated: true, completion: { () in
                print("completion handler back button")
//                self.NotesVC?.notes.removeAll()
//                self.NotesVC?.observeUserNotes()
//                self.NotesVC?.tableView.reloadData()
                
            })
        }
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
        textView.placeholder = ""
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
        //print("textview did change")
        toggleSaveButtonEnabled()
        
        

        //print("textview empty: ", textView.text.isEmpty)
        if textView.text.isEmpty {
            self.textView.placeholder = "Type note here..."
            toggleSaveButtonDisabled()
        }
    }

}
