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
    
    var id: String?
    var title: String?
    var text: String?
    var timestamp: NSNumber?
    var ownerId: String?
    
}
