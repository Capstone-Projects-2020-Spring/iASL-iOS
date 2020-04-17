//
//  User.swift
//  ImageClassification
//
//  Created by Liam Miller on 3/21/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

/**
 This is used to hold the id, the name, and the email of a user. This could be the current signed in user or this could be used as a list of users. User information is pulled from Firebase and stored in this class.
 */
class User: NSObject {
    ///unique id of the user as a string
    var id: String?
    ///name of the user as a string
    var name: String?
    ///email of the user as a string
    var email: String?
}
