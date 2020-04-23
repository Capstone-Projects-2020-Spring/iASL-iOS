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

    
    var remote: RemoteConversationVC?
    var login: LoginVC?
    var message: Message?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        remote = RemoteConversationVC()
        login = LoginVC()
        message = Message()
        
        print("called setup")
        
        login?.emailTextField.text = email
        login?.passwordTextField.text = password
        
        //need to create a message obj first
        
        message?.receiverId = "bill_id"
        message?.senderId = uid
        message?.text = "text"
        message?.timestamp = 1
    }
    
    override class func tearDown() {
        //
    }
    
    ///Checks if the observe message function is successful in calling by looking for a boolean representing success as a result
    func testObserveMessagesSucceeds() {
        
        //log the user in
//        login?.emailTextField.text = email
//        login?.passwordTextField.text = password
//        login?.handleLogin()
//        
//        print(login?.getCurrentUser())
        
        //call the function to see if it succeeded
        let chatVC = ChatVC()
//        chatVC.loginVC = login
//        chatVC.loginVC?.emailTextField.text = email
//        chatVC.loginVC?.passwordTextField.text = password
//        print(chatVC.loginVC?.emailTextField.text)
//        chatVC.loginVC?.handleLogin()
        //chatVC.emailTextField.text = email
        //chatVC.passwordTextField.text = password
        //chatVC.handleLoginForTesting(email: email, password: password)
        print("get current user: ", chatVC.getCurrentUser())
        let succeeded = chatVC.observeMessages()
        
//        XCTAssertTrue(succeeded)
    }
    
    ///Checks if the observe message function fails as a result of the user not being signed in by looking for a boolean representing success as a result
    func testObserveMessagesFails() {
        //log the user out
        remote?.handleLogout()
        
        //call the function to see if it failed
        let chatVC = ChatVC()
        let failed = chatVC.observeMessages()
        
        XCTAssertFalse(failed)
    }

}
