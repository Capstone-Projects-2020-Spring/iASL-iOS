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
    func chatPartnerId(uid: String) -> String? {
        print(senderId!)
        print(receiverId!)
        print(uid)
        if senderId == uid {
            print("receiver")
            return receiverId
        } else {
            print("sender")
            return senderId
        }
    }
    
    ///Gets and returns the UID of the current signed in user
    func getUid() -> String? {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("could not get the UID")
            return ""
        }
        return uid
    }
    
    ///Handles what happens when the user logins in with an existing account. For signing in during testing
    func handleLoginForTesting(email: String, password: String) {

        //sign in with username and password
        Auth.auth().signIn(withEmail: email, password: password) { (_, err) in
            if err != nil {
                print(err!)
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
}
