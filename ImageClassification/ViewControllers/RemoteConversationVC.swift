//
//  RemoteConversationVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/9/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class RemoteConversationVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var people = ["Ian Applebaum", "Leo Gomes", "Liam Miller", "Viet Pham", "Tarek Elseify", "Aidan Loza", "Shakeel Alibhai"]

    private let refreshControl = UIRefreshControl()

    //this is where all the messages will go
    var messages = [Message]()
    //for organizing messages by name and most recent
    var messagesDictionary = [String: Message]()
    
    let keychain = KeychainSwift(keyPrefix: "iasl_")

    let topBar = UIView()
    let topLabel = UILabel()
    let backButton = UIButton()
    let tableView = UITableView()
    let liveButton = UIButton()

    let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.layer.cornerRadius = 5
        //button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()

    // FIXME: Go back and fix this UI
    let addChatButton: UIButton = {
        let image: UIImage = UIImage(named: "plus")!
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(image, for: .normal) //FIXME: get a different logo
        button.layer.cornerRadius = button.frame.width / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleAddChat), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        topBarSetup()
        backButtonSetup()
        topLabelSetup()
        tableViewSetup()

        logoutButtonSetup()
        addChatButtonSetup()
        //composedMessageSetup()

        //observeMessages()
        observeUserMessages()

    }

    @objc func refreshTableViewOnPull() {
        print("refreshing table view thanks to pulling down")

        self.tableView.reloadData()

        refreshControl.endRefreshing()
    }

    func observeUserMessages() {

        guard let uid = Auth.auth().currentUser?.uid else {
            print("could not get UID")
            return
        }

        let ref = Database.database().reference().child("user-messages").child(uid)

        ref.observe(.childAdded, with: { (snapshot) in

            print(snapshot)

            let messageId = snapshot.key

            let messagesReference = Database.database().reference().child("messages").child(messageId)

            messagesReference.observeSingleEvent(of: .value, with: { (snapshot) in

                print(snapshot)

                //this is where the old observe messages stuff goes
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let message = Message()
                    message.receiverId = dictionary["receiverId"] as? String
                    message.senderId = dictionary["senderId"] as? String
                    message.text = dictionary["text"] as? String
                    message.timestamp = dictionary["timestamp"] as? NSNumber
                    //print(message.text)
                    //print(message.timestamp)

                    //add message to all the messages
                    //self.messages.append(message)

                    //one message per receiver

                    //finally, this is the solution to the problem commented our below (I think)
                    if let chatPartnerId = message.chatPartnerId() {
                        self.messagesDictionary[chatPartnerId] = message

                        print("keys: ", self.messagesDictionary.keys)
                        print("values: ", self.messagesDictionary.values)

                        self.messages = Array(self.messagesDictionary.values)

                        //sort messages by most recent
//                        self.messages.sorted { (message1, message2) -> Bool in
//                            return message1.timestamp?.intValue > message2.timestamp?.intValue
//                        }
                        
                        //this sort actually works and the previous one does not
                        self.messages.sort { (message1, message2) -> Bool in
                            return message1.timestamp?.intValue > message2.timestamp?.intValue
                        }
                        
                        //self.messages.sort(by: >)
                    }

//                    if let receiverId = message.receiverId {
//                        self.messagesDictionary[receiverId] = message
//
//                        print("keys: ",self.messagesDictionary.keys)
//                        print("values: ", self.messagesDictionary.values)
//
//                        self.messages = Array(self.messagesDictionary.values)
//
//                        //sort messages by most recent
//                        self.messages.sorted { (message1, message2) -> Bool in
//                            return message1.timestamp?.intValue > message2.timestamp?.intValue
//                        }
//                    }
                }

                print("dictionary length: ", self.messages.count)

                //reload the table
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            }, withCancel: nil)

        }, withCancel: nil)

    }

//    //gather all of the messages ever so we can organize them properly in the main table view
//    func observeMessages() {
//        let ref = Database.database().reference().child("messages")
//        ref.observe(.childAdded, with: { (snapshot) in
//
//            if let dictionary = snapshot.value as? [String: AnyObject] {
//                let message = Message()
//                message.receiverId = dictionary["receiverId"] as? String
//                message.senderId = dictionary["senderId"] as? String
//                message.text = dictionary["text"] as? String
//                message.timestamp = dictionary["timestamp"] as? NSNumber
//                //print(message.text)
//                //print(message.timestamp)
//
//                //add message to all the messages
//                self.messages.append(message)
//
//                //one message per receiver
//                if let receiverId = message.receiverId {
//                    self.messagesDictionary[receiverId] = message
//
//                    self.messages = Array(self.messagesDictionary.values)
//
//                    //sort messages by most recent
//                    self.messages.sorted { (message1, message2) -> Bool in
//                        return message1.timestamp?.intValue > message2.timestamp?.intValue
//                    }
//                }
//            }
//
//            //reload the table
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//
//        }, withCancel: nil)
//    }

    ///Add a user to a current conversation
    @objc func handleAddChat() {
        print("add chat button pressed")

        //call a new view controller
        let addChatVC = AddChatVC()
        addChatVC.remoteConversations = self //sets the reference variable to self so we can transition elsewhere
        addChatVC.modalTransitionStyle = .crossDissolve
        addChatVC.modalPresentationStyle = .fullScreen
        present(addChatVC, animated: true, completion: nil)
    }

    //FIXME: Maybe add a pop up message asking the user if they are sure they want to log out?
    ///handles the logout button, so it logs the user out of firebae and presents the login controller
    @objc func handleLogout() {

        print("handle logout tapped")

        //clear the arrays that hold user messages and reset the table
        messages.removeAll()
        messagesDictionary.removeAll()
        tableView.reloadData()

        //log the user out of firebase
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        //remove keys from keychain
        keychain.clear()
        
        //present the login screen
        let loginController = LoginVC()
        loginController.modalTransitionStyle = .crossDissolve
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: nil)
//*/
    }

    ///sets the anchors and adds the button to the top bar
    func logoutButtonSetup() {
        //x, y, height, width
        topBar.addSubview(logoutButton)

        logoutButton.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -10).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -10).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //logoutButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }

    func addChatButtonSetup() {
        view.addSubview(addChatButton)

        addChatButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addChatButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        addChatButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addChatButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

}

extension RemoteConversationVC {

    // MARK: Table View Stuff

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }

    //FIXME: Make a custom user cell here
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell") as! ChatUserCell
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "chatCell")

        //get the message
        let message = messages[indexPath.row]

        print("messages timestamp: ", message.timestamp!)

        //sets the message and does the work for applying it to a cell
        cell.message = message

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //let vc = ChatVC(collectionViewLayout: UICollectionViewFlowLayout())
        //let cell: UITableViewCell = tableView.cellForRow(at: indexPath)!

        let message = messages[indexPath.row]

        guard let chatPartnerId = message.chatPartnerId() else {
            return
        }

        let ref = Database.database().reference().child("users").child(chatPartnerId)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            //print(snapshot)

            guard let dictionary = snapshot.value as? [String: AnyObject] else {
                return
            }

            let user = User()
            user.name = dictionary["name"] as? String
            user.email = dictionary["email"] as? String

            //FIXME: this may be dictionary["id"] as? String
            user.id = chatPartnerId

            self.showChatVCForUser(user: user)

        }, withCancel: nil)

//        guard let name = cell.textLabel?.text else {
//            print("could not find name")
//            return
//        }
//        showChatVC(name: name)
        //navigationController?.pushViewController(vc, animated: true)
    }

    //FIXME: These two below need to change later once we have a working view controller in remote
    func showChatVCForUser(user: User) {

        messages.removeAll()
        messagesDictionary.removeAll()
        tableView.reloadData()

        observeUserMessages()

        let vc = ChatVC()
        vc.chatPartner = user
        //vc.topLabel.text = user.name //this has been moved to in ChatVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }

    func showChatVC(name: String) {
        let vc = ChatVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.topLabel.text = name
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

        tableView.register(ChatUserCell.self, forCellReuseIdentifier: "chatCell")
        refreshControl.addTarget(self, action: #selector(refreshTableViewOnPull), for: .valueChanged)

        //adding the pull to refresh
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
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

//        messages.removeAll()
//        messagesDictionary.removeAll()
//        observeUserMessages()
        //navigationController?.popViewController(animated: true)
    }

    func topLabelSetup() {
        topBar.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20).isActive = true
        topLabel.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -10).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        topLabel.text = "Chat"
        topLabel.font = UIFont.boldSystemFont(ofSize: 30)
        topLabel.textColor = .white
    }

}

// MARK: Functions that help with comparing message.timestamp.intValue in observeMessages() function

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
