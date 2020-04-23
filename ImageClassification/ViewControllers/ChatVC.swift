//
//  ChatVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/10/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Firebase

/**
 This class is used to show an individual chat between two users. It shows the title bar at the top with the chat partner's name, it has alll the messages between the two users, and it demonstrates our iASL keyboard in use.
 */
class ChatVC: UIViewController, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var loginVC: LoginVC? = nil

    //MARK: Constants
    ///A constant for the "messages" node in Firebase
    let messagesConstant: String = "messages"
    ///Constant for the cellId in the collectionview
    static let cellId = "cellId"

    ///Chat Partner of Type User from our swift classes. Used to get the name of the chat partner for the top bar
    var chatPartner: User? {
        didSet {
            topLabel.text = chatPartner?.name

            //observe the messages
            observeMessages()
        }
    }

    ///Array of type Message from our swift classes that holds all of the messages observed from Firebase
    var messages = [Message]()
    
    //MARK: Variables
    
    ///This is the message that is typed in the input box by the user
    let composedMessage = UITextView()
    ///This is the top bar that holds the user's name and has our navigation back button
    let topBar = UIView()
    ///The label that holds the name of the chat partner
    let topLabel = UILabel()
    ///The button for going back to the previous view, which is the list of active chats
    let backButton = UIButton()
    ///Button to be clicked by the user to send a message
    let sendButton = UIButton()
    ///Button used to switch between the iASL keyboard and the standard Apple Keyboard
    let keyboardButton = UIButton()

    ///This is the collection view that holds all of the messages sent between two users
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        return collection
    }()

    ///Function called when the view loads. Used to setup all of the important structural parts of the view controller.
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

    ///Called when the keyboard is about to show
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    ///Called when the keyboard is abouot to hide
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func test() -> Bool {
        return false
    }

    ///Observes messages from Firebase and loads them into an array of type Message to be used by the collectionview. Has logic for determining which messages were from the sender and which were from the receiver
    func observeMessages() -> Bool {

        guard let uid = Auth.auth().currentUser?.uid else {
            print("could not get the UID")
            return false
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
        
        return true
    }
    
    //MARK: CollectionView stuff

    ///Adds the collection view to the subview and defines the important aspects of the collection view
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

    ///Returns the number of messages so the collection view knows how many cells to load
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    ///Defines what happens at each cell in the collection view. This is where our custom collection view cell comes in handy.
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

    ///This function determines what the chat bubble is going to look like. If it is a sender message, it will be pink and on the right side of the collection view. If it is an incoming message, it will be gray and on the left side of the collection view.
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

    ///Determines the height of each cell in the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var height: CGFloat = 80

        //need to somehow guess the height based on the amount of text inside the bubble
        if let text = messages[indexPath.item].text {
            height = estimateFrameForText(text: text).height + 20 //20 is just a guess
        }

        return CGSize(width: view.frame.width, height: height)
    }

    ///Estimates the frame for the text in the cell
    private func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)

        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }

}

///Extension of the Chat View Controller that handles a lot of setup and handler functions
extension ChatVC {
    
    
    //MARK: Setup/Handler Functions
    

    ///Handles what happens when you send a message
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

        //clear the composed message part
        composedMessage.text = ""
    }

    ///Sets up the send button in the subveiw and defines its constraints and important features
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

    ///Sets up the composed message text view and defines its constraints and important features
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

    ///Adds the top bar to the subview and defines how it is supposed to look
    func topBarSetup() {
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 90).isActive = true
        topBar.backgroundColor = .black
    }

    ///Adds the back button to the top bar subview and defines what it looks like
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

    ///Handles what happens when the back button is tapped
    @objc func backButtonTapped() {
        print("sdf ")
        dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
    }

    ///Adds the top label for the name of the chat partner to the top bar subview and defines what the label looks like
    func topLabelSetup() {
        topBar.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -20).isActive = true
        topLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20).isActive = true
        topLabel.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -10).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //topLabel.text = "Remote Chat"
        topLabel.font = UIFont.boldSystemFont(ofSize: 30)
        topLabel.textColor = .white
    }

    func keybaordButtonSetup() {
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

    ///Handles what happens when the keyboard button is tapped. Handles logic for switching between different keyboards
    @objc func keyboardButtonTapped() {
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
    
    ///Handles what happens when the user logins in with an existing account. For signing in during testing
    func handleLoginForTesting(email: String, password: String) {

        //sign in with username and password
        Auth.auth().signIn(withEmail: email, password: password) { (_, err) in
            if err != nil {
                print("error", err!)
//                let alert = UIAlertController(title: "Alert", message: err?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
                return
            } else {
                //add email and password into keychain if they want
                //self.handleSaveKeychain(email: email, password: password)
                //successfully signed in
                print("you signed in successfully")
                //self.handleLeaveLogin()
            }
        }
    }
    
    func handleLogoutForTesting() {

        print("handle logout tapped")

        //log the user out of firebase
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }

    }
    
    func getCurrentUser() -> String {
        var variable = "failed"
        guard let uid = Auth.auth().currentUser?.uid else {
            print("could not get UID")
            return ""
        }

        let ref = Database.database().reference().child("users").child(uid)
        ref.observe(.value) { (snapshot) in

            if let dictionary = snapshot.value as? [String: AnyObject] {
                let name = dictionary["name"] as? String
                print(name!)
                variable = name!
            }
        }
        return variable
    }
    
    //MARK: Junky Functions
    ///Change the color of the status bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
          #if !targetEnvironment(simulator)
//          cameraCapture.checkCameraConfigurationAndStartSession()
          #endif
    }
    #if !targetEnvironment(simulator)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        cameraCapture.stopSession()
    }
    #endif

    ///Change the color of the status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    
}
