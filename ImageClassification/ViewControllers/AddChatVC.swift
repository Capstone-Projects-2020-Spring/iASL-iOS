//
//  AddChatVC.swift
//  ImageClassification
//
//  Created by Liam Miller on 3/25/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddChatVC: UIViewController {

    let cellId = "cellId"
    let usersConstant: String = "users"

    //an array of users
    var users = [User]()

    let topBar = UIView()
    let topLabel = UILabel()
    let backButton = UIButton()
    let tableView = UITableView()
    let liveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        topBarSetup()
        backButtonSetup()
        topLabelSetup()
        tableViewSetup()

        getUsers()

    }

    ///gets all of the users from the database
    func getUsers() {
        Database.database().reference().child(self.usersConstant).observe(.childAdded, with: { (snapshot) in
            //print(snapshot)

            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User()
                //this needs to be exact in firebase as it is in the User object
                //user.setValuesForKeys(dictionary)

                //set the values the safe way
                user.id = snapshot.key //gets the id, since that is the key
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String

                //add the user to the users array
                self.users.append(user)

                //call the table view to reload
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            }
        }, withCancel: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId) //FIXME: change this later

        //set the user for each cell
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email

        return cell
    }

    //FIXME: move this
    ///reference variable so we can transition into chatVC via remote conversations
    var remoteConversations: RemoteConversationVC?

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            print("dismissed completed")

            let user = self.users[indexPath.row]
            //print(cell.textLabel?.text)

            //show the chatVC via remote conversations vc with the user's name
            self.remoteConversations?.showChatVCForUser(user: user)
        }
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
        topLabel.text = "Add a Chat"
        topLabel.font = UIFont.boldSystemFont(ofSize: 30)
        topLabel.textColor = .white
    }
}

extension AddChatVC: UITableViewDelegate, UITableViewDataSource {

}
