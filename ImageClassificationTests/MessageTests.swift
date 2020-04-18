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
    
    var remote: RemoteConversationVC?
    var login: LoginVC?
    var message: Message?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        remote = RemoteConversationVC()
        login = LoginVC()
        message = Message()
        
        login?.emailTextField.text = email
        login?.passwordTextField.text = password
        
        //need to create a message obj first
        
        message?.receiverId = "bill_id"
        message?.senderId = uid
        message?.text = "text"
        message?.timestamp = 1
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    ///Will check if the chat partner is the receiver. Output is equal chat partner IDs
    func testChatPartnerIsReceiver() {
        
        //let asyncExpectation = expectation(description: "Async block executed")
        DispatchQueue.main.async {
            //make sure user is logged out
            self.remote?.handleLogout()
            
            //log user in
            self.login?.handleLogin()
            
            //ask who the chat partner is
            let whoIsChatPartner = self.message?.chatPartnerId()
            
            XCTAssertEqual(self.partner, whoIsChatPartner)
            //asyncExpectation.fulfill()
        }
        //waitForExpectations(timeout: 1, handler: nil)
    }
    
    ///Will check if the chat partner is the sender. Output is equal chat partner IDs
    func testChatPartnerIsSender() {
        
    }

}
