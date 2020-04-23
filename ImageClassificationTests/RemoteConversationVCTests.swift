//
//  RemoteConversationsTest.swift
//  ImageClassificationTests
//
//  Created by Liam Miller on 4/18/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest
@testable import iASL

class RemoteConversationVCTests: XCTestCase {
    
    let partner = "bill_id"
    
    //need to sign in
    let email = "Test1@gmail.com"
    let password = "password"
    let uid = "ppmK3FXm7gPc6HwhS5wOvBtfLFP2"
    
    var remote: RemoteConversationVC?

    override func setUp() {
        remote = RemoteConversationVC()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    ///Test if the observe user messages function can run by looking for a boolean representing success as a result
    func testObserveUserMessagesSuccess() {
        let observeUserMessagesTrue = remote?.observeUserMessages(uid: uid)
        
        XCTAssertTrue(observeUserMessagesTrue!)
    }
    
    ///Test if the observe user messages function can fail by looking for a boolean representing failure as a result
    func testObserveUserMessagesFailure() {
        let observeUserMessagesFalse = remote?.observeUserMessages(uid: "")
        
        XCTAssertFalse(observeUserMessagesFalse!)
    }
    
    ///Test if the observe delete messages function can run by looking for a boolean representing success as a result
    func testObserveDeleteMessagesSuccess() {
        let deleteTestSuccess = remote?.handleDeleteNote(uid: uid)
        
        XCTAssertTrue(deleteTestSuccess!)
    }
    
    ///Test if the observe delete messages function can fail by looking for a boolean representing failure as a result
    func testObserveDeleteMessagesFailure() {
        let deleteTestFailure = remote?.handleDeleteNote(uid: "")
        
        XCTAssertFalse(deleteTestFailure!)
    }

}
