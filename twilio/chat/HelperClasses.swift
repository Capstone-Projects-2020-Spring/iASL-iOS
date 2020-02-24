//
//  HelperClasses.swift
//  ImageClassification
//
//  Created by Ian Applebaum on 2/23/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
class TCHChannels {
	// FIXME: Need implementation

}
class TCHChannel{
	// FIXME: Need implementation
}
class TCHMember{
// FIXME: Need implementation
}
class TCHMessage:Hashable{
	var message: String?
	static func == (lhs: TCHMessage, rhs: TCHMessage) -> Bool {
		return lhs.message == rhs.message
	}
    var hashValue: Int {
        return (message).hashValue
    }
	// FIXME: Need implementation
}
