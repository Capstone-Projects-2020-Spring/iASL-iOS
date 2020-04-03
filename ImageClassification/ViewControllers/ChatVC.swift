//
//  ChatVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/10/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Firebase

//FIXME: Fix keyboard height with respect to input box

//FIXME: Obviously the whole chat bubble part

//FIXME: Add feature to tap on screen and get rid of keyboard

//FIXME: Name at top, if too long, gets cut off

class ChatVC: UIViewController, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let composedMessage = UITextView()
    let topBar = UIView()
    let topLabel = UILabel()
    let backButton = UIButton()
    let tableView = UITableView()

    let messagesConstant: String = "messages"

    //so we know which user we are talking to
    var chatPartner: User? {
        didSet {
            topLabel.text = chatPartner?.name

            //observe the messages
            observeMessages()
        }
    }

    var messages = [Message]()

    //delete this once you can get messages from Firebase
    var tempMessages = [Message]()

    var tempMessage1 = Message()
    var tempMessage2 = Message()
    var tempMessage3 = Message()
    var tempMessage4 = Message()

    func loadTempMessage() {
        tempMessage1.receiverId = "receiverId"
        tempMessage1.senderId = "senderId"
        tempMessage1.text = "Text Message 1"
        tempMessage1.timestamp = 1

        tempMessage2.receiverId = "receiverId"
        tempMessage2.senderId = "senderId"
        tempMessage2.text = "Text Message 1"
        tempMessage2.timestamp = 2

        tempMessage3.receiverId = "receiverId"
        tempMessage3.senderId = "senderId"
        tempMessage3.text = "Text Message 1"
        tempMessage3.timestamp = 3

        tempMessage4.receiverId = "receiverId"
        tempMessage4.senderId = "senderId"
        tempMessage4.text = "Text Message 1"
        tempMessage4.timestamp = 4

        tempMessages = [tempMessage1, tempMessage2, tempMessage3, tempMessage4]
    }

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
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        topBarSetup()
        backButtonSetup()
        topLabelSetup()
        //tableViewSetup()
        // Do any additional setup after loading the view.

        sendButtonSetup()
		composedMessageSetup()

        collectionViewSetup()
//		bottomConstraint = composedMessage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
//		bottomConstraint?.isActive = true
//		view.addConstraint(bottomConstraint!)
//		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: , object: nil)
//		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        let child = Caboard()
//        addChild(child)
//        child.view.frame = view.frame
//        view.addSubview(child.view)
//        child.didMove(toParent: self)

        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)

    }

    func observeMessages() {

        guard let uid = Auth.auth().currentUser?.uid else {
            print("could not get the UID")
            return
        }

        let userMessagesRef = Database.database().reference().child("user-messages").child(uid)
        userMessagesRef.observe(.childAdded, with: { (snapshot) in

            let messageId = snapshot.key
            let messagesRef = Database.database().reference().child("messages").child(messageId)
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in

                guard let dictionary = snapshot.value as? [String: AnyObject] else {
                    print("could not find dictionary")
                    return
                }

                let message = Message()
                message.receiverId = dictionary["receiverId"] as? String
                message.senderId = dictionary["senderId"] as? String
                message.text = dictionary["text"] as? String
                message.timestamp = dictionary["timestamp"] as? NSNumber

                if message.chatPartnerId() == self.chatPartner?.id {
                    //add the messages we received to the messages array
                    self.messages.append(message)

                    //reload the table
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }

                }

            }, withCancel: nil)

        }, withCancel: nil)
    }

    func collectionViewSetup() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: composedMessage
			.topAnchor).isActive = true

        //makes it always scroll vertical, even when there are not enough collection cells to require scrolling
        collectionView.alwaysBounceVertical = true

        //makes it so the top message is not snug to the top of the view
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatVC.cellId, for: indexPath) as! ChatMessageCell

        //this is where you will set the text of each message
        let message = messages[indexPath.row]
        cell.textView.text = message.text

        setupCell(cell: cell, message: message)

        //modify the bubbleView width?
        cell.bubbleViewWidthAnchor?.constant = estimateFrameForText(text: message.text!).width + 32 //32 is just a guess

        return cell
    }

    func setupCell(cell: ChatMessageCell, message: Message) {
        if message.senderId == Auth.auth().currentUser?.uid {
            //outgoing blue
            cell.bubbleView.backgroundColor = .systemPink
            cell.textView.textColor = .white

            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
        } else {
            //incoming gray
            cell.bubbleView.backgroundColor = .lightGray
            cell.textView.textColor = .black

            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true

        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var height: CGFloat = 80

        //need to somehow guess the height based on the amount of text inside the bubble
        if let text = messages[indexPath.item].text {
            height = estimateFrameForText(text: text).height + 20 //20 is just a guess
        }

        return CGSize(width: view.frame.width, height: height)
    }

    private func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)

        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }

    //change the color of the status bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
		  #if !targetEnvironment(simulator)
//		  cameraCapture.checkCameraConfigurationAndStartSession()
		  #endif
    }
    #if !targetEnvironment(simulator)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        cameraCapture.stopSession()
    }
    #endif

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
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

    ///handles what happens when you send a message
    @objc func handleSendButton() {
        print(composedMessage.text!)

        guard let messageText = composedMessage.text else {
            print("could not get message")
            return
        }

        let ref = Database.database().reference().child(self.messagesConstant)
        //gets an auto ID for each message
        let childRef = ref.childByAutoId()

        //receiver is who you are talking to, sender is you

        guard let receiverId = chatPartner?.id, let senderId = Auth.auth().currentUser?.uid else {
            print("could not get necessary message information")
            return
        }

        let timestamp: NSNumber = NSNumber(value: NSDate().timeIntervalSince1970)

        let values = ["receiverId": receiverId, "senderId": senderId, "text": messageText, "timestamp": timestamp] as [String: Any]

        childRef.updateChildValues(values) { (error, _) in
            if error != nil {
                print(error!)
                return
            }

            //you've added your message successfully\
            print("successfully added message")

            //need to also save to new node for cost related issues
            let userMessagesRef = Database.database().reference().child("user-messages").child(senderId)

            let messageId = childRef.key
            let userValue = [messageId: 1] as! [String: Any]

            userMessagesRef.updateChildValues(userValue) { (error2, _) in
                if error2 != nil {
                    print(error2!)
                    return
                }

                //you've added to the user-messages node for message senders
                print("you've added to the user-messages node for senders")
            }

            let receiverUserMessagesRef = Database.database().reference().child("user-messages").child(receiverId)
            receiverUserMessagesRef.updateChildValues(userValue) { (error2, _) in
                if error2 != nil {
                    print(error2!)
                    return
                }

                //you've added a node to the user-messages node for message receivers
                print("you've added to the user-messages node for receivers")
            }

        }
        //this is where it needs to send the message to firebase
    }

    func sendButtonSetup() {
        view.addSubview(sendButton)
		 sendButton.translatesAutoresizingMaskIntoConstraints = false
		sendButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
		sendButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
		sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
		sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -215).isActive = true
	}

    func previewViewSetup() {
//        view.addSubview(previewView)
//        previewView.translatesAutoresizingMaskIntoConstraints = false
//        previewView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        previewView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
//        previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
//        previewView.backgroundColor = .blue
//
//        previewView.layer.cornerRadius = 5

        //going to make it the send button for now
        //FIXME: Remove this and add a send button at some point
    }

    // MARK: Ep 8 for styling this stuff

    //FIXME: Add placeholder logic manually since you can't use a text field here, won't expand vertically

    //FIXME: Can we use enter to send a message and not go lower in the textview?

    //FIXME: Fix issue with keyboard covering textview
    func composedMessageSetup() {
        view.addSubview(composedMessage)
        composedMessage.translatesAutoresizingMaskIntoConstraints = false
        composedMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
		composedMessage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -215).isActive = true
//		composedMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        composedMessage.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -5).isActive = true
        composedMessage.heightAnchor.constraint(equalToConstant: 150).isActive = true
		composedMessage.center = view.center
        composedMessage.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        composedMessage.layer.borderWidth = 1
        composedMessage.layer.cornerRadius = 10
		composedMessage.inputView = Caboard(target: composedMessage)
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
