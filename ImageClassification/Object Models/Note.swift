//
//  Note.swift
//  ImageClassification
//
//  Created by Liam Miller on 4/4/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Firebase

///this will hold each note that is saved in Firebase
class Note: NSObject {
    ///unique ID of the note
    var id: String?
    ///title of the specific note
    var title: String?
    ///text of the specific note
    var text: String?
    ///the exact time the note was saved
    var timestamp: NSNumber?
    ///unique ID of the user who created this note
    var ownerId: String?

}
