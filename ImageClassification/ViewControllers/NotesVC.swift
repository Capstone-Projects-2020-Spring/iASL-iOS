//
//  NotesVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/9/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Firebase

/**
 This class is responsible for the main notes screen. It holds the table view of all of the users's notes as well as ways for users to create new notes and delete old ones.
 */
class NotesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    ///Array of all the notes of the current user
    var notes = [Note]()
    ///Constant for the 'user-notes' node in Firebase
    let userNotesConstant: String = "user-notes"
    ///Variable for handling the pull to refresh for the table view
    private let refreshControl = UIRefreshControl()
    ///Variable for the top bar
    let topBar = UIView()
    ///Variable for the top label which holds the name of the feature
    let topLabel = UILabel()
    ///Variable for the back button for when the user wants to go back to the previous view controller
    let backButton = UIButton()
    ///Table view variable for holding all of the users notes
    let tableView: UITableView = {
        let table = UITableView()
        //table.separatorStyle = .singleLine
        //table.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        return table
    }()
    ///Button for creating a new note
    let createNoteButton = UIButton()

    ///Function that gets called initially and loads all of the setup functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        topBarSetup()
        backButtonSetup()
        topLabelSetup()
        tableViewSetup()
        createNoteButtonSetup()
            //observeUserNotes()

    }
    
    ///Gets and returns the UID of the user who is signed in
    func getUid() -> String {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("could not get the UID")
            return ""
        }
        return uid
    }

    ///Handles what happens when the user pulls on the table view to refresh
    @objc func refreshTableViewOnPull() {
        print("refreshing table view thanks to pulling down")

        notes.removeAll()
        self.tableView.reloadData()
        observeUserNotes(uid: getUid())

        refreshControl.endRefreshing()
    }

    ///What happens when the view is about to disappear.
    override func viewWillDisappear(_ animated: Bool) {
        print("view will disappear")
        notes.removeAll()
        tableView.reloadData()
        observeUserNotes(uid: getUid())
    }

    ///This is what happens when the view did appear
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
//        notes.removeAll()
//        tableView.reloadData()
//        observeUserNotes()
        perform(#selector(refreshTableViewOnPull), with: nil, afterDelay: 0.2)
        //tableView.reloadData()
    }

    ///Determines which interface orientations are supported
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

    ///Function for observing notes from firebase (used to gather list of notes for user to see in their list of notes)
    func observeUserNotes(uid: String) -> Bool {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            print("could not get UID")
//            return
//        }
        
        if uid == "" {
            return false
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

                }
                self.tableView.reloadData()
            }, withCancel: nil)
            self.tableView.reloadData()
        }, withCancel: nil)
        
        return true
    }

    /**
     Handles what happens when a note is to be deleted
     
     - Parameters: the ID of the note to be deleted
     */
    func handleDeleteNote(noteId: String, uid: String) -> Bool {

        //need to get the ID of the user
//        guard let uid = Auth.auth().currentUser?.uid else {
//            print("could not get UID")
//            return
//        }
        
        if uid == "" {
            return false
        }

        //need to get a reference to their user-notes node
        let userNotesRef = Database.database().reference().child(self.userNotesConstant).child(uid).child(noteId)
        userNotesRef.removeValue()

        //need to get a reference to their notes-node
        let notesRef = Database.database().reference().child("notes").child(noteId)
        notesRef.removeValue()

        return true
    }

    /**
     Presents an alert to the user with optinons if they tried to delete a note. They can proceed with deletion or cancel it
     
     - Parameters: The ID of the note to be deleted and the indexPath from the table view cell where the note is being deleted
     */
    func handleDeleteNoteAreYouSure(noteId: String, indexPath: IndexPath) {

        let saveResponse = UIAlertAction(title: "Save", style: .default) { (_) in
            //respond to user selection of action
            print("save pressed")
        }

        let doNotSaveResponse = UIAlertAction(title: "Delete", style: .default) { (_) in
            //respond to user selection
            print("remove changes pressed")
            print("noteId", noteId)
            print("indexpath.row: ", indexPath.row)

            self.notes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .bottom)
            self.tableView.reloadData()
            self.handleDeleteNote(noteId: noteId, uid: self.getUid())
        }

        let alert = UIAlertController(title: "This is permanent!", message: "Are you sure you want to delete this?", preferredStyle: .alert)
        alert.addAction(saveResponse)
        alert.addAction(doNotSaveResponse)

        self.present(alert, animated: true) {
            //alert was presented
        }
    }

}

///Extension for the NotesVC that holds most of the set up functions and some table view related functions
extension NotesVC {

    ///Counts the number of items in a table view based on the size of the notes array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    ///Each cell in the table view gets handled here
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesTableViewCell") as! NotesTableViewCell
        cell.accessibilityIdentifier = "notesTableViewCell_\(indexPath.row)" //for testing
        
        let note = notes[indexPath.row]
        cell.note = note

        //cell?.textLabel?.text = testNotes[indexPath.row].text
        return cell
    }

    ///Checks if the note is trying to be deleted at a certain row in the table view
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

    ///Returns the height of each row in the table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    ///Returns the estimated height of each row in the table view
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    ///Selecting a specific row in the table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        notes.removeAll()
//        tableView.reloadData()
//
//        observeUserNotes()

        //observeUserNotes()
        let note = notes[indexPath.row]

        showNoteFromTableView(note: note)

    }

    /**
     When a user clicks on a note in the table view, this will get called and will send the user to the note creation/editing view controller
     
     - Parameters: the note to be presented in the next view controller
     */
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

    ///Change the color of the status bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        print("view will appear")
    }

    ///Change the color of the status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    ///Set up the table view with constraints
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
        tableView.accessibilityIdentifier = "testingNotesVCTableView"
        refreshControl.addTarget(self, action: #selector(refreshTableViewOnPull), for: .valueChanged)

        //adding the pull to refresh
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }

    ///Setting up the top bar with constraints
    func topBarSetup() {
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 90).isActive = true
        topBar.backgroundColor = .black
    }

    ///Sets up the back button and defines its constraints
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

    ///Sets up the create note button and defines its constraints
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

    ///Handles the create note button being tapped
    @objc func createNoteButtonTapped() {

        let vc = CreateNoteVC()

        //need to send a nil note so it knows to make a new one and not overwrite an old one
        vc.note = nil
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        //vc.noteTitle.text = "New Note"
        present(vc, animated: true, completion: nil)
    }

    ///Handles the back button being tapped
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
    }

    ///Sets up the top label for the name of the view controller and defines its constraints
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
///Private function for comparing two elements
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
///Private function for comparing two elements
private func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (lefthandSide?, righthandSide?):
        return lefthandSide > righthandSide
    default:
        return rhs < lhs
    }
}
