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
    let sendButton = UIButton()
    let keyboardButton = UIButton()
    
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
        hideKeyboardWhenTappedAround()
        
        topBarSetup()
        backButtonSetup()
        topLabelSetup()

        sendButtonSetup()
        keybaordButtonSetup()
		composedMessageSetup()

        collectionViewSetup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
        
        print(message.timestamp!)

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


extension ChatVC {


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

        //gets it in milliseconds
        let timestamp: NSNumber = NSNumber(value: NSDate().timeIntervalSince1970 * 1000)
        
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
        //sendButton.leadingAnchor.constraint(equalTo: composedMessage.leadingAnchor, constant: 5).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
		sendButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
		sendButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        sendButton.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        sendButton.addTarget(self, action: #selector(handleSendButton), for: .touchUpInside)
	}


    func composedMessageSetup() {
        view.addSubview(composedMessage)
        composedMessage.translatesAutoresizingMaskIntoConstraints = false
        composedMessage.leadingAnchor.constraint(equalTo: keyboardButton.trailingAnchor, constant: 10).isActive = true
		composedMessage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
//		composedMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        composedMessage.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10).isActive = true
        composedMessage.heightAnchor.constraint(equalToConstant: 40).isActive = true
		composedMessage.center = view.center
        composedMessage.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        composedMessage.layer.borderWidth = 1
        composedMessage.layer.cornerRadius = 10
		composedMessage.inputView = CameraBoard(target: composedMessage)
        composedMessage.font = UIFont.systemFont(ofSize: 20)
        composedMessage.autocorrectionType = .no
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

    func keybaordButtonSetup(){
        view.addSubview(keyboardButton)
        keyboardButton.translatesAutoresizingMaskIntoConstraints = false
        keyboardButton.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 10).isActive = true
        keyboardButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -10).isActive = true
        keyboardButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        keyboardButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        keyboardButton.setImage(#imageLiteral(resourceName: "keyboard-1"), for: .normal)
        keyboardButton.setImage(#imageLiteral(resourceName: "yoBlack"), for: .selected)
        keyboardButton.addTarget(self, action: #selector(keyboardButtonTapped), for: .touchUpInside)
    }
    
    @objc func keyboardButtonTapped(){
        if keyboardButton.isSelected {
            keyboardButton.isSelected = false
            composedMessage.inputView = CameraBoard(target: composedMessage)
            composedMessage.reloadInputViews()
        } else {
            keyboardButton.isSelected = true
            composedMessage.inputView = nil
            composedMessage.reloadInputViews()
        }
        
        
    }
}

extension NSDate {
    func toMillis() -> NSNumber {
        return NSNumber(value:Int64(timeIntervalSince1970 * 1000))
    }
    static func fromMillis(millis: NSNumber?) -> NSDate? {
        return millis.map() { number in NSDate(timeIntervalSince1970: Double(truncating: number) / 1000)}
    }

    static func currentTimeInMillis() -> NSNumber {
        return NSDate().toMillis()
    }
}
