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

/**
 This class handles the ability for the user to choose a partner to chat with.
 */
class AddChatVC: UIViewController {

    ///Variable that holds the cell ID constant
    let cellId = "cellId"
    ///Variable that holds the "users" constant for Firebase
    let usersConstant: String = "users"

    ///An array of users
    var users = [User]()
    ///Reference variable so we can transition into chatVC via remote conversations
    var remoteConversations: RemoteConversationVC?
    ///Variable for a uiview for the top bar of the screen
    let topBar = UIView()
    ///Variable for the top label that holds the name of the view controller
    let topLabel = UILabel()
    ///Button for users to go back to the previous view controller
    let backButton = UIButton()
    ///Variable for the table view that holds all of the users' names
    let tableView = UITableView()

    ///View did load function that calls all of the setup functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        topBarSetup()
        backButtonSetup()
        topLabelSetup()
        tableViewSetup()

        getUsers()

    }

    ///Gets all of the users from the database and stores them in an array of Users
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
    
}

///Extension of AddChatVC that holds most of the setup functions for the views
extension AddChatVC: UITableViewDelegate, UITableViewDataSource {
    
    ///Returns the size of the users array so that the table view knows how many rows to load
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    ///Determines what data gets loaded in each row of the table view, returns a table view cell with that data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId) //FIXME: change this later
        
        //set the user for each cell
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
    }
    
    ///Handles what happens when a user taps on a specific cell in the table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            print("dismissed completed")
            
            let user = self.users[indexPath.row]
            //print(cell.textLabel?.text)
            
            //show the chatVC via remote conversations vc with the user's name
            self.remoteConversations?.showChatVCForUser(user: user)
        }
    }
    
    ///Sets up the table view and defines its constraints
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
    
    ///Sets up the top bar view and defines its constraints
    func topBarSetup() {
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 90).isActive = true
        topBar.backgroundColor = .black
    }
    
    ///Sets up the back button view and defines its constraints
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
    
    ///Handles what happens when the back button is tapped
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
    }
    
    ///Sets up the top label view and defines its constraints
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
    
    ///Change the color of the status bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    ///Change the color of the status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
