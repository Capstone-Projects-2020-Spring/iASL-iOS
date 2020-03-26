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

class Message: NSObject {
    var receiverId: String?
    var senderId: String?
    var text: String?
    var timestamp: NSNumber?
    
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
