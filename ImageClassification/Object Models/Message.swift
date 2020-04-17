//
//  Message.swift
//  ImageClassification
//
//  Created by Liam Miller on 3/21/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Firebase

/**
 This class stores information on an indivudal message from our messaging feature. Whenever a message is sent or received, it is stored in this class, typically as an array. The messages information is retrieved from Firebase and stored here when needed.
 */
class Message: NSObject {
    ///this is the unique ID of the person who is receiving the message
    var receiverId: String?
    ///unique ID of the person who is sending the message
    var senderId: String?
    ///the actual text of this specific message
    var text: String?
    ///this is the exact time that the message was sent
    var timestamp: NSNumber?

    ///this function returns the ID of the person who is not the current user and who is the person the current user is chatting with
    func chatPartnerId() -> String? {
        if senderId == Auth.auth().currentUser?.uid {
            return receiverId
        } else {
            return senderId
        }
    }

//    init(receiverId: String, senderId: String, text: String, timestamp: String) {
//        self.receiverId = receiverId
//        self.senderId = senderId
//        self.text = text
//        self.timestamp = timestamp
//    }
}
