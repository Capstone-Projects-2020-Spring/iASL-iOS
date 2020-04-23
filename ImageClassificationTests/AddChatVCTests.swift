//
//  AddChatVCTests.swift
//  ImageClassificationTests
//
//  Created by Liam Miller on 4/18/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest
@testable import iASL

class AddChatVCTests: XCTestCase {
    
    var addChat: AddChatVC?

    override func setUp() {
        addChat = AddChatVC()
    }
    
    override func tearDown() {
        
    }
    
    ///Test if the get users function is successful by looking for a boolean that represents success as a result
    func testGetUsers() {
        let success = addChat?.getUsers()
        
        XCTAssertTrue(success!)
    }

}
