//
//  ChatVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/10/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

//FIXME: Fix keyboard height with respect to input box

//FIXME: Obviously the whole chat bubble part

//FIXME: Add feature to tap on screen and get rid of keyboard

//FIXME: Name at top, if too long, gets cut off

class ChatVC: UIViewController, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let previewView = PreviewView()
    let composedMessage = UITextView()
    let topBar = UIView()
    let topLabel = UILabel()
    let backButton = UIButton()
    let tableView = UITableView()
    
    static let cellId = "cellId"
    
    //FIXME: will probably delete this or relocate it
    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemPink, for: .normal)
        button.addTarget(self, action: #selector(handleSendButton), for: .touchUpInside)
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return collection
    }()
    
        //let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
//    //this is where everything will go so we can get it under the top bar
//    let containerView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .white
        
//        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
//        //collectionView.setCollectionViewLayout(layout, animated: true)
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        
        
        topBarSetup()
        backButtonSetup()
        topLabelSetup()
        //tableViewSetup()
        // Do any additional setup after loading the view.
        previewViewSetup()
        composedMessageSetup()

        sendButtonSetup()
        
        collectionViewSetup()
        
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)

        
    }
    
//    ///going to hold the messages here
//    func containerViewSetup() {
//        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        containerView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
//        containerView.bottomAnchor.constraint(equalTo: previewView.topAnchor).isActive = true
//    }
    
    func collectionViewSetup() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: previewView.topAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatVC.cellId, for: indexPath)
        
        cell.backgroundColor = .blue
        
        return cell
    }
    
    
}

//class ChatVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//    let previewView = PreviewView()
//    let composedMessage = UITextView()
//    let topBar = UIView()
//    let topLabel = UILabel()
//    let backButton = UIButton()
//    let tableView = UITableView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//        topBarSetup()
//        backButtonSetup()
//        topLabelSetup()
//        tableViewSetup()
//        // Do any additional setup after loading the view.
//        previewViewSetup()
//        composedMessageSetup()
//
//    }
//
//}

extension ChatVC {

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChatTableViewCell
//        cell.textLabel?.text = "asdf"
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableViewSetup() {
//        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.separatorStyle = .none
//        tableView.allowsSelection = false
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
    
    @objc func handleSendButton() {
        print(composedMessage.text!)
        
        //this is where it needs to send the message to firebase
    }
    
    func sendButtonSetup() {
        previewView.addSubview(sendButton)
        
        sendButton.topAnchor.constraint(equalTo: previewView.topAnchor).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: previewView.bottomAnchor).isActive = true
        sendButton.rightAnchor.constraint(equalTo: previewView.rightAnchor).isActive = true
        sendButton.leftAnchor.constraint(equalTo: previewView.leftAnchor).isActive = true
    }

    func previewViewSetup() {
        view.addSubview(previewView)
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        previewView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        previewView.backgroundColor = .black
        
        //going to make it the send button for now
        //FIXME: Remove this and add a send button at some point
    }

    
    //MARK: Ep 8 for styling this stuff
    
    //FIXME: Add placeholder logic manually since you can't use a text field here, won't expand vertically
    
    //FIXME: Can we use enter to send a message and not go lower in the textview?
    func composedMessageSetup() {
        view.addSubview(composedMessage)
        composedMessage.translatesAutoresizingMaskIntoConstraints = false
        composedMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        composedMessage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        composedMessage.trailingAnchor.constraint(equalTo: previewView.leadingAnchor, constant: -5).isActive = true
        composedMessage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        composedMessage.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        composedMessage.layer.borderWidth = 1
        composedMessage.layer.cornerRadius = 10
        //composedMessage.delegate = self
        //composedMessage.enablesReturnKeyAutomatically = false
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
        //backButton.backgroundColor = .red
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        print("sdf ")
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
        //topLabel.text = "Remote Chat"
        topLabel.font = UIFont.boldSystemFont(ofSize: 30)
        topLabel.textColor = .white
    }

}
