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

///This will hold each note that is saved in Firebase
class Note: NSObject {
    ///Unique ID of the note
    var id: String?
    ///Title of the specific note
    var title: String?
    ///Text of the specific note
    var text: String?
    ///The exact time the note was saved
    var timestamp: NSNumber?
    ///Unique ID of the user who created this note
    var ownerId: String?
}
