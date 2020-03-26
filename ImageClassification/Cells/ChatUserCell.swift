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
            
            if let receiverId = message?.receiverId {
                let ref = Database.database().reference().child("users").child(receiverId)
                ref.observe(.value, with: { (snapshot) in
                    
                    print(snapshot)
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        
                        let name = dictionary["name"] as? String
                        
                        
                        self.textLabel?.text = name
                        
                    }
                    
                }, withCancel: nil)
            }
            
            //getting the timestamp and making it look nice
            if let seconds = message?.timestamp?.doubleValue {
                let timestampDate = NSDate(timeIntervalSince1970: seconds)
                
                let dateFormat = DateFormatter()
                //FIXME: Get rid of the seconds later
                dateFormat.dateFormat = "hh:mm:ss a"
                
                detailTextLabel?.text = dateFormat.string(from: timestampDate as Date)
                
            }
            
        }
    }
    
//    let name: UILabel = {
//        let label = UILabel()
//
//        return label
//    }()
//
//    let mostRecentMessage: UILabel = {
//        let label = UILabel()
//
//        return label
//    }()
//
//    let timestampLabel: UILabel = {
//        let label = UILabel()
//
//        return label
//    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: (textLabel?.frame.origin.y)! - 2, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        detailTextLabel?.frame = CGRect(x: 64, y: (detailTextLabel?.frame.origin.y)! + 2, width: (detailTextLabel?.frame.width)!, height: (detailTextLabel?.frame.height)!)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        
//        setupNameLabel()
//        setupMessageLabel()
//        setupTimestampLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setupNameLabel() {
//        name.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
//        name.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
//        name.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        //FIXME: might need a width constraint
//    }
//
//    func setupMessageLabel() {
//        mostRecentMessage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
//        mostRecentMessage.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
//        //mostRecentMessage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
//        mostRecentMessage.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
//
//    func setupTimestampLabel() {
//        timestampLabel.leftAnchor.constraint(equalTo: name.rightAnchor, constant: 5).isActive = true
//        timestampLabel.centerYAnchor.constraint(equalTo: name.centerYAnchor).isActive = true
//        timestampLabel.heightAnchor.constraint(equalTo: name.heightAnchor).isActive = true
//    }
    
    
}
