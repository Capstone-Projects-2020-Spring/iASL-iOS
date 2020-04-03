//
//  ChatVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/10/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Foundation

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

	   // Handles all data preprocessing and makes calls to run inference through the `Interpreter`.
	   private var modelDataHandler: ModelDataHandler? =
		   ModelDataHandler(modelFileInfo: MobileNet.modelInfo, labelsFileInfo: MobileNet.labelsInfo)
    //delete this once you can get messages from Firebase
    let tempMessages = [
        Message(toId: "toId", fromId: "fromId", text: "Text Message 1", timestamp: "timestamp"),
        Message(toId: "toId", fromId: "fromId", text: "Text Message 2", timestamp: "timestamp"),
        Message(toId: "toId", fromId: "fromId", text: "Text Message 3 that could be pretty long perhaps", timestamp: "timestamp"),
        Message(toId: "toId", fromId: "fromId", text: "Text Message 4", timestamp: "timestamp")
    ]

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

        //let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()

//    //this is where everything will go so we can get it under the top bar
//    let containerView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
	var bottomConstraint: NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .white

//        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
//        //collectionView.setCollectionViewLayout(layout, animated: true)
//        collectionView.delegate = self
//        collectionView.dataSource = self

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
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        let child = Caboard()
//        addChild(child)
//        child.view.frame = view.frame
//        view.addSubview(child.view)
//        child.didMove(toParent: self)

        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)

    }
	@objc func handleKeyboardNotification(notification: Notification) {
		if let frameObject: AnyObject = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject? {
			let keyboardRect = frameObject.cgRectValue

			//bottomConstraint?.isActive = false
			//bottomConstraint? = composedMessage.bottomAnchor.constraint(equalTo: topAnchor, constant: -20)//composedMessage.frame.height - 20 - keyboardRect!.height
			//bottomConstraint?.isActive = true
			self.view.layoutIfNeeded()
			 // use keyboardRect to calculate the frame of the textfield
		}
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
        return tempMessages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatVC.cellId, for: indexPath) as! ChatMessageCell

        //this is where you will set the text of each message
        let message = tempMessages[indexPath.row]
        cell.textView.text = message.text

        //modify the bubbleView width?
        cell.bubbleViewWidthAnchor?.constant = estimateFrameForText(text: message.text!).width + 32 //32 is just a guess

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var height: CGFloat = 80

        //need to somehow guess the height based on the amount of text inside the bubble
        if let text = tempMessages[indexPath.item].text {
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

    @objc func handleSendButton() {
        print(composedMessage.text!)

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
