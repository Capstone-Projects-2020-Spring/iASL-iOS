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
    ///This is the unique ID of the person who is receiving the message
    var receiverId: String?
    ///Unique ID of the person who is sending the message
    var senderId: String?
    ///The actual text of this specific message
    var text: String?
    ///This is the exact time that the message was sent
    var timestamp: NSNumber?

    ///This function returns the ID of the person who is not the current user and who is the person the current user is chatting with
    func chatPartnerId() -> String? {
        if senderId == Auth.auth().currentUser?.uid {
            return receiverId
        } else {
            return senderId
        }
    }
}
