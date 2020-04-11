//
//  NotesVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/9/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Firebase

class NotesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //var testNotes = ["Ian", "Leo", "Liam", "Viet", "Tarek", "Aidan", "Shakeel"]
    var testNotes = [Note]()
    var notes = [Note]()
    //var notesDictionary = [String: Note]()
    
    let userNotesConstant: String = "user-notes"
    
    private let refreshControl = UIRefreshControl()
    
    func setupFakeNotes() {
        let note1 = Note()
        note1.ownerId = "owner1"
        note1.text = "this is note 1"
        note1.title = "title 1"
        note1.timestamp = 4
        
        let note2 = Note()
        note2.ownerId = "owner2"
        note2.text = "this is note 2"
        note2.title = "title 2"
        note2.timestamp = 3
        
        let note3 = Note()
        note3.ownerId = "owner3"
        note3.text = "this is note 3"
        note3.title = "title 3"
        note3.timestamp = 2
        
        let note4 = Note()
        note4.ownerId = "owner4"
        note4.text = "wwwwwwwwwwwwwwwwwwwwwwwwwwwwww"
        note4.title = "fourth title"
        note4.timestamp = 1
        
        
        testNotes.append(note1)
        testNotes.append(note2)
        testNotes.append(note3)
        testNotes.append(note4)
    }

    let topBar = UIView()
    let topLabel = UILabel()
    let backButton = UIButton()
    let tableView: UITableView = {
        let table = UITableView()
        //table.separatorStyle = .singleLine
        //table.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        return table
    }()
    let createNoteButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        print("view did load")
        
        setupFakeNotes()
        
        topBarSetup()
        backButtonSetup()
        topLabelSetup()
        tableViewSetup()
        createNoteButtonSetup()
            //observeUserNotes()
        
    }
    
    //var notesVC: NotesVC?
    
    @objc func refreshTableViewOnPull() {
        print("refreshing table view thanks to pulling down")
        
        notes.removeAll()
        self.tableView.reloadData()
        observeUserNotes()
        

        refreshControl.endRefreshing()
    }
    
    //these two below are like a wack way of solving the reload table view issue
    override func viewWillDisappear(_ animated: Bool) {
        print("view will disappear")
        notes.removeAll()
        tableView.reloadData()
        observeUserNotes()
    }

    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
//        notes.removeAll()
//        tableView.reloadData()
//        observeUserNotes()
        perform(#selector(refreshTableViewOnPull), with: nil, afterDelay: 0.2)
        //tableView.reloadData()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
//    func getCurrentUser() {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            print("could not get UID")
//            return
//        }
//
//        let ref = Database.database().reference().child("users").child(uid)
//        ref.observe(.value) { (snapshot) in
//
//            if let dictionary = snapshot.value as? [String: AnyObject] {
//                let name = dictionary["name"] as? String
//                print(name)
//            }
//        }
//    }
    
    ///function for observing notes from firebase (used to gather list of notes for user to see in their list of notes)
    func observeUserNotes() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("could not get UID")
            return
        }

        //gets the id of the user inside the user-notes node
        //userNotesConstant = "user-notes"
        let ref = Database.database().reference().child(self.userNotesConstant).child(uid)
        //snapshot is a collection of things inside the node
        ref.observe(.childAdded, with: { (snapshot) in

            //value of the node key
            let noteId = snapshot.key

            //get the notes of all the children nodes from the user-notes node
            let notesReference = Database.database().reference().child("notes").child(noteId)

            notesReference.observeSingleEvent(of: .value, with: { (snapshot) in

                //gets a dictionary (key, value). You can see what is in the dictionary per snapshot.value below
                if let dictionary = snapshot.value as? [String: AnyObject] {

                    //add this note to the notes array
                    let note = Note()
                    note.ownerId = dictionary["ownerId"] as? String
                    note.title = dictionary["title"] as? String
                    note.text = dictionary["text"] as? String
                    note.timestamp = dictionary["timestamp"] as? NSNumber
                    note.id = snapshot.key
                    
                    //creates an array of notes. this is where the list of notes gets presented to the user
                    self.notes.append(note)
                    print("num of notes: ", self.notes.count)
                    
                    //sort the notes by timestamp
                    self.notes.sort { (note1, note2) -> Bool in
                        return note1.timestamp?.intValue > note2.timestamp?.intValue
                    }
                    print("\(note.text)")
                    
                }
                self.tableView.reloadData()
            }, withCancel: nil)
            self.tableView.reloadData()
        }, withCancel: nil)
    }
    
    func handleDeleteNote(noteId: String) {
        
        //need to get the ID of the user
        guard let uid = Auth.auth().currentUser?.uid else {
            print("could not get UID")
            return
        }
        
        //need to get a reference to their user-notes node
        let userNotesRef = Database.database().reference().child(self.userNotesConstant).child(uid).child(noteId)
        userNotesRef.removeValue()
        
        //need to get a reference to their notes-node
        let notesRef = Database.database().reference().child("notes").child(noteId)
        notesRef.removeValue()
        
    }
    
    func handleDeleteNoteAreYouSure(noteId: String, indexPath: IndexPath) {
        
        let saveResponse = UIAlertAction(title: "Save", style: .default) { (action) in
            //respond to user selection of action
            print("save pressed")
        }
        
        let doNotSaveResponse = UIAlertAction(title: "Delete", style: .default) { (action) in
            //respond to user selection
            print("remove changes pressed")
            print("noteId", noteId)
            print("indexpath.row: ", indexPath.row)
            
            self.notes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .bottom)
            self.tableView.reloadData()
            self.handleDeleteNote(noteId: noteId)
        }
        
        let alert = UIAlertController(title: "This is permanent!", message: "Are you sure you want to delete this?", preferredStyle: .alert)
        alert.addAction(saveResponse)
        alert.addAction(doNotSaveResponse)
        
        self.present(alert, animated: true) {
            //alert was presented
        }
    }
    
}

extension NotesVC {

    ///counts the number of items in a table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    ///each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesTableViewCell") as! NotesTableViewCell
        
        let note = notes[indexPath.row]
        cell.note = note;
        
        //cell?.textLabel?.text = testNotes[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let noteToDelete = notes[indexPath.row]
            let noteId = noteToDelete.id!
            print("ready to delete")
            //print(noteToDelete.text!)
            
            handleDeleteNoteAreYouSure(noteId: noteId, indexPath: indexPath)
            
            //notes.remove(at: indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: .bottom)
            //handleDeleteNote(noteId: noteId!)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    ///selecting a specific row in the table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        notes.removeAll()
//        tableView.reloadData()
//
//        observeUserNotes()
        
        //observeUserNotes()
        let note = notes[indexPath.row]
        
        showNoteFromTableView(note: note)

    }
    
    func showNoteFromTableView(note: Note) {
//        notes.removeAll()
//        tableView.reloadData()
//
//        observeUserNotes()
        
        let vc = CreateNoteVC()
        vc.note = note
        //vc.NotesVC = notesVC
        
        //also need to send the key of the note so we know where to update it?
        vc.noteToUpdateKey = note.id
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.noteTitle.text = note.title
        present(vc, animated: true, completion: nil)
    }
    
    ///change the color of the status bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        print("view will appear")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    ///set up the table view with constraints and such
    func tableViewSetup() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: "notesTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(refreshTableViewOnPull), for: .valueChanged)

        //adding the pull to refresh
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }

    ///setting up the top bar with constraints and such
    func topBarSetup() {
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 90).isActive = true
        topBar.backgroundColor = .black
    }

    ///set up the back button
    func backButtonSetup() {
        topBar.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 20).isActive = true
        backButton.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -10).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        let tintedImage = #imageLiteral(resourceName: "back").withRenderingMode(.alwaysTemplate)
        backButton.setImage(tintedImage, for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    ///set up the create note button
    func createNoteButtonSetup() {

        view.addSubview(createNoteButton)
        createNoteButton.translatesAutoresizingMaskIntoConstraints = false
        createNoteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        createNoteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        createNoteButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        createNoteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        createNoteButton.setTitle("New Note", for: .normal)
        createNoteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        createNoteButton.backgroundColor = .blue
        createNoteButton.addTarget(self, action: #selector(createNoteButtonTapped), for: .touchUpInside)
    }

    ///handles the create note button being tapped
    @objc func createNoteButtonTapped() {
        
        let vc = CreateNoteVC()
        
        //need to send a nil note so it knows to make a new one and not overwrite an old one
        vc.note = nil
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        //vc.noteTitle.text = "New Note"
        present(vc, animated: true, completion: nil)
    }

    ///handles the back button being tapped
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
    }

    ///sets up the top label for the name of the view controller
    func topLabelSetup() {
        topBar.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20).isActive = true
        topLabel.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -10).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        topLabel.text = "Notes"
        topLabel.font = UIFont.boldSystemFont(ofSize: 30)
        topLabel.textColor = .white
    }

}

// MARK: Functions that help with comparing note.timestamp.intValue in observeUserNotes() function

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
///private function for comparing two elements
private func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (lefthandSide?, righthandSide?):
        return lefthandSide < righthandSide
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
///private function for comparing two elements
private func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (lefthandSide?, righthandSide?):
        return lefthandSide > righthandSide
    default:
        return rhs < lhs
    }
}

