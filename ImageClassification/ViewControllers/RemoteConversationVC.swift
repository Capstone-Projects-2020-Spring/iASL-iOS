//
//  RemoteConversationVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/9/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Firebase

class RemoteConversationVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var people = ["Ian Applebaum", "Leo Gomes", "Liam Miller", "Viet Pham", "Tarek Elseify", "Aidan Loza", "Shakeel Alibhai"]
    
    //this is where all the messages will go
    var messages = [Message]()

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
        
        tableView.register(ChatUserCell.self, forCellReuseIdentifier: "chatCell")
        
        logoutButtonSetup()
        addChatButtonSetup()
        //composedMessageSetup()
        
        observeMessages()
        
    }
    
    //gather all of the messages ever so we can organize them properly in the main table view
    func observeMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let message = Message()
                message.receiverId = dictionary["receiverId"] as? String
                message.senderId = dictionary["senderId"] as? String
                message.text = dictionary["text"] as? String
                message.timestamp = dictionary["timestamp"] as? String
                //print(message.text)
                
                //add message to all the messages
                self.messages.append(message)
            }
            
            //reload the table
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }, withCancel: nil)
    }
    
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
        
        //log the user out of firebase
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        //present the login screen
        let loginController = LoginVC()
        loginController.modalTransitionStyle = .crossDissolve
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: nil)
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
        
        let message = messages[indexPath.row]
        
        
        //FIXME: This will get moved into custom user cell
        if let receiverId = message.receiverId {
            let ref = Database.database().reference().child("users").child(receiverId)
            ref.observe(.value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    let name = dictionary["name"] as? String
                    
                    
                    cell.textLabel?.text = name
                    
                }
                
            }, withCancel: nil)
        }
        
        
        //cell?.textLabel?.text = message.receiverId
        //cell.textLabel?.text = message.receiverId! + " " + message.timestamp!
        
        //some magic to get the timestamp correctly
//        if let timestamp = Double(message.timestamp!) {
//            print("we have the timestamp")
//            let timestampDate = NSDate(timeIntervalSince1970: timestamp)
//
//            cell.detailTextLabel?.text = timestampDate.description
//
//        }
        
        cell.detailTextLabel?.text = message.timestamp
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let vc = ChatVC(collectionViewLayout: UICollectionViewFlowLayout())
        let cell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        guard let name = cell.textLabel?.text else {
            print("could not find name")
            return
        }
        showChatVC(name: name)
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    //FIXME: These two below need to change later once we have a working view controller in remote
    func showChatVCForUser(user: User) {
        let vc = ChatVC()
        vc.chatPartner = user
        vc.topLabel.text = user.name
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
        topLabel.text = "Chat"
        topLabel.font = UIFont.boldSystemFont(ofSize: 30)
        topLabel.textColor = .white
    }

}
