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

/**
 This class is responsible for giving users the ability to create new notes and edit old ones. 
 */
class CreateNoteVC: UIViewController {

    ///This is the note that will be set from the NotesVC
    var note: Note?
    ///This is where the note to be updated can be found in firebase
    var noteToUpdateKey: String?
    ///Variable for the constant "notes" for Firebase
    let notesConstant: String = "notes"
    ///Variable for the constant "user-notes" for Firebase
    let userNotesConstant: String = "user-notes"
    ///Variable for the back button to go to the previous veiw controller
    let backButton = UIButton()
    ///Variable for the textview for the text of the note
    let textView = KMPlaceholderTextView()
    ///Variable for the textfield that holds the title of the note
    let noteTitle = UITextField()

    ///Save button for saving notes
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

    ///View did load function that calls all of the setup functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSaveNoteButton()
        backButtonSetup()
        noteTitleSetup()
        textViewSetup()
        loadNote()
    }

    ///If the note already exists, loads the contents into the VC. if it does not exist, set placeholders
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

    ///Handles what happens when a new note is made
    func handleNewNote(noteText: String, title: String, owner: String) -> Bool {

        print("handle new note")
        toggleSaveButtonDisabled()

        //need to save a message here, just like with messaging
//        guard let noteText = textView.text, let title = noteTitle.text else {
//            print("could not get message")
//            return false
//        }
        
        if owner == "" {
            return false
        }

        //get a reference ot the database at the "notes" node
        let ref = Database.database().reference().child(self.notesConstant)
        //gets an auto ID for each message
        let childRef = ref.childByAutoId()

        //owner is the owner id of the note
//        guard let owner = Auth.auth().currentUser?.uid else {
//            print("could not get necessary message information")
//            return false
//        }

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
        
        return true
    }

    ///Need to be able to overwrite an existing note
    func handleUpdateNote(noteText: String, title: String, owner: String) -> Bool {
        print("handle update note")
        toggleSaveButtonDisabled()

        //need to save a message here, just like with messaging
//        guard let noteText = textView.text, let title = noteTitle.text else {
//            print("could not get message")
//            return
//        }

        //owner is the owner id of the note
//        guard let owner = Auth.auth().currentUser?.uid else {
//            print("could not get necessary message information")
//            return
//        }
        
        if owner == "" {
            return false
        }

        //key is the node at which we are updating the note
        guard let key = self.noteToUpdateKey else {
            return false
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

        return true
    }

}

///Extension of the CreateNoteVC that holds most of the setup functions
extension CreateNoteVC: UITextViewDelegate, UITextFieldDelegate {
    
    ///Handles the constraints and set up of the save button
    func setupSaveNoteButton() {
        view.addSubview(saveButton)
        
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        toggleSaveButtonEnabled()
    }
    
    ///Gets and returns the UID of the user who is signed in
    func getUid() -> String? {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("could not get the UID")
            return ""
        }
        return uid
    }
    
    ///Handles what happens when a note is saved
    @objc func handleSaveNote() {
        print("save note button pressed")
        //print("Here is the note: ", textView.text!)
        
        guard let noteText = textView.text, let title = noteTitle.text else {
            return
        }
        
        guard let uid = getUid() else {
            return
        }

        
        //two cases: new note created and old note needs to be updated
        if note == nil {
            let newNote = Note()
            newNote.title = "Title"
            note = newNote
            
            handleNewNote(noteText: noteText, title: title, owner: uid)
            
            dismiss(animated: true, completion: { () in
                print("completion handler new note")
                //self.NotesVC?.notes.removeAll()
                //self.NotesVC?.observeUserNotes()
                //self.NotesVC?.tableView.reloadData()
                
            })
        } else {
            handleUpdateNote(noteText: noteText, title: title, owner: uid)
            //            self.NotesVC?.notes.removeAll()
            //            self.NotesVC?.tableView.reloadData()
            //            self.NotesVC?.observeUserNotes()
        }
        
    }
    
    ///Sets the save button to enabled and makes the color normal
    func toggleSaveButtonEnabled() {
        saveButton.isEnabled = true
        saveButton.alpha = 1
    }
    
    ///Sets the save button to disabled and makes the color of the bottom dim
    func toggleSaveButtonDisabled() {
        saveButton.isEnabled = false
        saveButton.alpha = 0.2
    }

    ///Set up for the back button and defines its constraints
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

    ///What happens when the back button is tapped, dismisses the view controller
    @objc func backButtonTapped() {

        //need to check if user has changed their note and not saved
        if saveButton.isEnabled {
            print("save button enabled")

            let saveResponse = UIAlertAction(title: "Save", style: .default) { (_) in
                //respond to user selection of action
                print("save pressed")
                self.handleSaveNote()
                self.dismiss(animated: true, completion: nil)
            }

            let doNotSaveResponse = UIAlertAction(title: "Remove changes", style: .default) { (_) in
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

    ///Sets up the note title and defines its constraints
    func noteTitleSetup() {
        view.addSubview(noteTitle)
        noteTitle.translatesAutoresizingMaskIntoConstraints = false
        noteTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        noteTitle.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10).isActive = true
        noteTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        noteTitle.rightAnchor.constraint(equalTo: saveButton.leftAnchor, constant: -10).isActive = true
        noteTitle.font = UIFont.boldSystemFont(ofSize: 30)
    }

    ///Sets up the main text view and defines its constraints
    func textViewSetup() {
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.placeholder = ""
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: noteTitle.bottomAnchor, constant: 5).isActive = true
        textView.font = UIFont.systemFont(ofSize: 20)
		textView.inputView = CameraBoard(target: textView)
        textView.delegate = self
    }

    ///If the text changed in the view controller, toggle the save button
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
