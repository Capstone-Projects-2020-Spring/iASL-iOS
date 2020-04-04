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
    var notesDictionary = [String: Note]()
    
    let userNotesConstant: String = "user-notes"
    
    func setupFakeNotes() {
        let note1 = Note()
        note1.ownerId = "owner1"
        note1.text = "this is note 1"
        note1.title = "title1"
        note1.timestamp = 4
        
        let note2 = Note()
        note2.ownerId = "owner2"
        note2.text = "this is note 2"
        note2.title = "title2"
        note2.timestamp = 3
        
        
        let note3 = Note()
        note3.ownerId = "owner3"
        note3.text = "this is note 3"
        note3.title = "title3"
        note3.timestamp = 2
        
        
        testNotes.append(note1)
        testNotes.append(note2)
        testNotes.append(note3)
    }

    let topBar = UIView()
    let topLabel = UILabel()
    let backButton = UIButton()
    let tableView = UITableView()
    let createNoteButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupFakeNotes()
        
        topBarSetup()
        backButtonSetup()
        topLabelSetup()
        tableViewSetup()
        createNoteButtonSetup()
        
        observeUserNotes()
        
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    ///function for observing notes from firebase
    func observeUserNotes() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("could not get UID")
            return
        }

        //gets the id of the user inside the user-notes node
        let ref = Database.database().reference().child(self.userNotesConstant).child(uid)

        ref.observe(.childAdded, with: { (snapshot) in

            print(snapshot)

            let noteId = snapshot.key

            //get the notes of all the children nodes from the user-notes node
            let notesReference = Database.database().reference().child("notes").child(noteId)

            notesReference.observeSingleEvent(of: .value, with: { (snapshot) in

                print(snapshot)

                //this is where the old observe messages stuff goes
                if let dictionary = snapshot.value as? [String: AnyObject] {

                    //add this note to the notes array
                    let note = Note()
                    note.ownerId = dictionary["ownerId"] as? String
                    note.title = dictionary["title"] as? String
                    note.text = dictionary["text"] as? String
                    note.timestamp = dictionary["timestamp"] as? NSNumber
                    note.id = snapshot.key
                    
                    self.notes.append(note)
                    
                    //sort the notes by timestamp
                    self.notes.sort { (note1, note2) -> Bool in
                        return note1.timestamp?.intValue > note2.timestamp?.intValue
                    }
                }


                //reload the table
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            }, withCancel: nil)

        }, withCancel: nil)
    }
    
}

extension NotesVC {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = notes[indexPath.row].text
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CreateNoteVC()
        vc.note = notes[indexPath.row]
        
        //also need to send the key of the note so we know where to update it?
        vc.noteToUpdateKey = notes[indexPath.row].id
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.noteTitle.text = notes[indexPath.row].title
        present(vc, animated: true, completion: nil)
    }
    
    //change the color of the status bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    func tableViewSetup() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    func topBarSetup() {
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 90).isActive = true
        topBar.backgroundColor = .black
    }

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

    @objc func createNoteButtonTapped() {
        
        let vc = CreateNoteVC()
        
        //need to send a nil note so it knows to make a new one and not overwrite an old one
        vc.note = nil
        //vc.modalTransitionStyle = .crossDissolve
        //vc.modalPresentationStyle = .fullScreen
        vc.noteTitle.text = "New Note"
        present(vc, animated: true, completion: nil)
    }

    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
    }

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
private func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (lefthandSide?, righthandSide?):
        return lefthandSide > righthandSide
    default:
        return rhs < lhs
    }
}

