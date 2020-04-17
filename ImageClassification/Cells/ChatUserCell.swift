//
//  ChatUserCell.swift
//  ImageClassification
//
//  Created by Liam Miller on 3/25/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import Firebase
import UIKit

///This class is for creating a custom cell in the table view of our main messaging feature screen. It handles the design of all the pieces that make up our custom cell and hanldes some logic for handling which information goes where.
class ChatUserCell: UITableViewCell {

    ///In the table view, this sets the message and does the work for getting the name of the user and the message
    var message: Message? {
        didSet {

            //calls the Message object model function
            if let id = message?.chatPartnerId() {
                let ref = Database.database().reference().child("users").child(id)
                ref.observe(.value, with: { (snapshot) in

                    //print(snapshot)

                    if let dictionary = snapshot.value as? [String: AnyObject] {

                        let name = dictionary["name"] as? String

                        //self.textLabel?.text = name
                        self.nameLabel.text = name

                    }

                }, withCancel: nil)
            }

            //get the message text
            if let messageText = message?.text {
                if messageText.count > 25 {
                    let messageTextNewEndIndex = messageText.index((messageText.startIndex), offsetBy: 25)
                    let shortenedMessageText = messageText[..<messageTextNewEndIndex]
                    self.mostRecentMessageLabel.text = "\"" + shortenedMessageText + "...\""
                } else {
                    self.mostRecentMessageLabel.text = "\"" + messageText + "...\""
                }
            }

            //getting the timestamp and making it look nice
            if let milliseconds = message?.timestamp?.doubleValue {
                let seconds = milliseconds / 1000
                let timestampDate = NSDate(timeIntervalSince1970: seconds)

                let dateFormat = DateFormatter()
                //FIXME: Get rid of the seconds later
                dateFormat.dateFormat = "hh:mm a"

                //detailTextLabel?.text = dateFormat.string(from: timestampDate as Date)
                self.timestampLabel.text = dateFormat.string(from: timestampDate as Date)
            }

            //detailTextLabel?.text = message?.text

        }
    }

    ///This is a closure for the label that holds the name of the chatter
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()

    ///This is a closure for the label that holds the text of the most recent message sent in the chat
    let mostRecentMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    ///This is a closure for the timestamp label that holds the time that the most recently sent message was sent
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    ///function for laying out the subviews
    override func layoutSubviews() {
        super.layoutSubviews()

    }

    ///Init function that is called whenever this class is used. This calls the main set up functions for the constraints and the subviews
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        setupNameLabel()
        setupMessageLabel()
        setupTimestampLabel()
    }

    ///Required init function in case of fatal error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    ///adds the name label to the subview and defines where in the subveiw it will be placed
    func setupNameLabel() {
        self.addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
    }

    ///adds the most recent message label to the subview and defines where in the subveiw it will be placed
    func setupMessageLabel() {
        self.addSubview(mostRecentMessageLabel)
        mostRecentMessageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        mostRecentMessageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    ///adds the timestamp label to the subview and defines where in the subveiw it will be placed
    func setupTimestampLabel() {
        self.addSubview(timestampLabel)
        timestampLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        timestampLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
    }

}
