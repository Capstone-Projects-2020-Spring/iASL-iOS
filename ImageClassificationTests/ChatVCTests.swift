//
//  ChatVCTest.swift
//  ImageClassificationTests
//
//  Created by Liam Miller on 4/17/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest
@testable import iASL

class ChatVCTests: XCTestCase {
    
    let partner = "bill_id"
    
    //need to sign in
    let email = "Test1@gmail.com"
    let password = "password"
    let uid = "ppmK3FXm7gPc6HwhS5wOvBtfLFP2"

    
    var chat: ChatVC?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        chat = ChatVC()
    }
    
    override class func tearDown() {
        //
    }
    
    ///Checks if the observe message function is successful in calling by looking for a boolean representing success as a result
    func testObserveMessagesSucceeds() {
        
        //call the function to see if it succeeded
        let succeeded = chat?.observeMessages(uid: uid)
        
        XCTAssertTrue(succeeded!)
    }
    
    ///Checks if the observe message function fails as a result of the user not being signed in by looking for a boolean representing success as a result
    func testObserveMessagesFails() {
        
        //call the function to see if it failed
        let failed = chat?.observeMessages(uid: "")
        
        XCTAssertFalse(failed!)
    }

}
