//
//  Message.swift
//  ImageClassification
//
//  Created by Liam Miller on 3/21/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

class Message: NSObject {
    var toId: String?
    var fromId: String?
    var text: String?
    var timestamp: String?

    init(toId: String, fromId: String, text: String, timestamp: String) {
        self.toId = toId
        self.fromId = fromId
        self.text = text
        self.timestamp = timestamp
    }
}
