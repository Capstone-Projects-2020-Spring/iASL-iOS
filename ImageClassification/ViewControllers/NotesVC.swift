//
//  NotesVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/9/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class NotesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var notes = ["Ian","Leo","Liam","Viet","Tarek","Aidan","Shakeel"]
    
    let topBar = UIView()
    let topLabel = UILabel()
    let backButton = UIButton()
    let tableView = UITableView()
    let createNoteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        topBarSetup()
        backButtonSetup()
        topLabelSetup()
        tableViewSetup()
        createNoteButtonSetup()
    }
    

}

extension NotesVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = notes[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CreateNoteVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.noteTitle.text = notes[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
    
    
    func tableViewSetup(){
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

    
    func topBarSetup(){
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
        backButton.backgroundColor = .red
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
    
    @objc func createNoteButtonTapped(){
        let vc = CreateNoteVC()
        //vc.modalTransitionStyle = .crossDissolve
        //vc.modalPresentationStyle = .fullScreen
        vc.noteTitle.text = "New Note"
        present(vc, animated: true, completion: nil)
    }
    
    @objc func backButtonTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    func topLabelSetup(){
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
