//
//  MessageTest.swift
//  ImageClassificationTests
//
//  Created by Liam Miller on 4/17/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest
@testable import iASL

class MessageTests: XCTestCase {
    
    let partner = "bill_id"
    
    //need to sign in
    let email = "Test1@gmail.com"
    let password = "password"
    let uid = "ppmK3FXm7gPc6HwhS5wOvBtfLFP2"
    
    var message: Message?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()

        message = Message()
        

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        message = nil
        super.tearDown()
    }
    
    //FIXME: For some reason, it needs me to keychain in first in the app before calling this, or it will fail. Can't find a solution
    
    ///Will check if the chat partner is the receiver. Output is equal chat partner IDs
    func testChatPartnerIsReceiver() {
        
        message?.receiverId = "bill_id"
        message?.senderId = uid
        message?.text = "text"
        message?.timestamp = 1

        let whoIsChatPartner = message?.chatPartnerId(uid: uid)
            
        XCTAssertEqual(partner, whoIsChatPartner)

    }
    
    ///Will check if the chat partner is the sender. Output is equal chat partner IDs
    func testChatPartnerIsSender() {
        
        message?.receiverId = uid
        message?.senderId = "bill_id"
        message?.text = "text"
        message?.timestamp = 1
        
        let whoIsChatPartner = message?.chatPartnerId(uid: uid)
            
        XCTAssertEqual(partner, whoIsChatPartner)
        
    }

}
