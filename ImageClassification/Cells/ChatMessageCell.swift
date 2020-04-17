//
//  ChatMessageCell.swift
//  ImageClassification
//
//  Created by Liam Miller on 3/21/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

/**
 This is a custom cell for the collection view we use in the chat view contoller. It creates and handles the bubbles for each message sent and received and their location on the view.
 */
class ChatMessageCell: UICollectionViewCell {
    
    //MARK: Reference Variables
    ///Reference variable for the message bubble view's width anchor. Helpful for later changing the bubble from a pink sender to a gray receiver message.
    var bubbleViewWidthAnchor: NSLayoutConstraint?
    ///Reference variable for the messaging bubble view's right anchor. Helpful for later changing the bubble from a pink sender to a gray receiver message.
    var bubbleViewRightAnchor: NSLayoutConstraint?
    ///Reference variable for the messaging bubble view's left anchor. Helpful for later changing the bubble from a pink sender to a gray receiver message.
    var bubbleViewLeftAnchor: NSLayoutConstraint?

    ///This is the textview that holds the actual text of a message sent or received
    let textView: UITextView = {
        let text = UITextView()
        text.text = "This is where the message will go"
        text.font = UIFont.systemFont(ofSize: 16)
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        //text.isUserInteractionEnabled = false
        text.isEditable = false
        return text
    }()

    ///This is a custom view closure that shapes the message bubbles
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()

    ///This is called each time the collection view cell is used. It is being used to call the set up functions for the message bubbles and the text view that holds the text
    override init(frame: CGRect) {
        super.init(frame: frame)

        bubbleViewSetup()
        textViewSetup()
        
    }

    ///Required function for checking if there is a fatal error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    ///Adds the bubble view to the subview and sets the constraints for the bubble view
    func bubbleViewSetup() {
        addSubview(bubbleView)
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        bubbleViewRightAnchor?.isActive = true

        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        bubbleViewLeftAnchor?.isActive = true

        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        bubbleViewWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleViewWidthAnchor?.isActive = true

        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }

    ///Adds the text view to the subview and defines the constraints for the text view
    func textViewSetup() {
        addSubview(textView)
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: 0).isActive = true

        //textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        //textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
