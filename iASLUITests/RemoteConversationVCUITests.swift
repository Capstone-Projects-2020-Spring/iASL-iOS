//
//  RemoteConversationVCUITests.swift
//  iASLUITests
//
//  Created by Liam Miller on 4/18/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest

class RemoteConversationVCUITests: XCTestCase {
    
    let partner = "bill_id"
    
    //need to sign in
    let email = "Test1@gmail.com"
    let password = "password"
    let uid = "ppmK3FXm7gPc6HwhS5wOvBtfLFP2"

    override func setUp() {
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        
    }
    
    ///Test if the observe user messages function can run by looking for a boolean representing success as a result
    func testObserveUserMessagesSuccess() {
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Already a user? Login"]/*[[".buttons[\"Already a user? Login\"].staticTexts[\"Already a user? Login\"]",".staticTexts[\"Already a user? Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let emailTextField = app.textFields["Email Address"]
        emailTextField.tap()
        emailTextField.typeText(email)
        
        let passwordTextField = app.secureTextFields["Password"]
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        app.buttons["Login"].tap()
                
        
    }
    
    ///Test if the add chat button takes the user to a new view. Ouput is the existence of an element in the next view controller
    func testAddChatButtonGoesToNewView() {
        
    }
    
    ///Test if note checking creates an alert. Output is the existence of an alert
    func testHandleDeleteNoteAreYouSure() {
        
    }
    
    ///Test if the logout button works as expected by seeing if a button on the login view becomes present. Output is the existence of an element from the login vc
    func testHandleLogout() {
        
    }

}
