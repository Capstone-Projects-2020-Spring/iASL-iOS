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

class ChatUserCell: UITableViewCell {

    //in the table view thing, sets the message and does the work for getting the name and the message
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

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()

    let mostRecentMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    let timestampLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

//        textLabel?.frame = CGRect(x: 64, y: (textLabel?.frame.origin.y)! - 2, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
//        detailTextLabel?.frame = CGRect(x: 64, y: (detailTextLabel?.frame.origin.y)! + 2, width: (detailTextLabel?.frame.width)!, height: (detailTextLabel?.frame.height)!)

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        setupNameLabel()
        setupMessageLabel()
        setupTimestampLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupNameLabel() {
        self.addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
    }

    func setupMessageLabel() {
        self.addSubview(mostRecentMessageLabel)
        mostRecentMessageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        mostRecentMessageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
    }

    func setupTimestampLabel() {
        self.addSubview(timestampLabel)
        timestampLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        timestampLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
    }

}
