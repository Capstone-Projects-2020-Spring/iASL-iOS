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
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Already a user? Login"]/*[[".buttons[\"Already a user? Login\"].staticTexts[\"Already a user? Login\"]",".staticTexts[\"Already a user? Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let emailTextField = app.textFields["Email Address"]
        emailTextField.tap()
        emailTextField.typeText(email)
        
        let passwordTextField = app.secureTextFields["Password"]
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        app.buttons["Login"].tap()
        sleep(5)
        app.buttons["chatIcon"].tap()
    }
    
    override func tearDown() {
        
    }
    
    ///Test if the add chat button takes the user to a new view. Ouput is the existence of an element in the next view controller
    func testAddChatButtonGoesToNewView() {
        
        let app = XCUIApplication()
        app.buttons["Add"].tap()
        let titleLabel = app.staticTexts["Add a Chat"]
        
        XCTAssertTrue(titleLabel.exists)
    }
    
    ///Test if note checking creates an alert. Output is the existence of an alert
    func testHandleDeleteNoteAreYouSure() {
        
        let app = XCUIApplication()
        app.tables["testingRemoteVCTableView"]/*@START_MENU_TOKEN@*/.staticTexts["09:37 PM"]/*[[".cells[\"remoteTableViewCell_0\"].staticTexts[\"09:37 PM\"]",".staticTexts[\"09:37 PM\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        //app.buttons["back"].tap()
        
        app.tables["testingRemoteVCTableView"]/*@START_MENU_TOKEN@*/.buttons["trailing0"]/*[[".cells[\"remoteTableViewCell_0\"]",".buttons[\"Delete\"]",".buttons[\"trailing0\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let popup = app.alerts["This is permanent!"].scrollViews.otherElements.containing(.staticText, identifier:"This is permanent!").element
        
        XCTAssertTrue(popup.exists)
                
    }
    
    ///Test if the logout button works as expected by seeing if a button on the login view becomes present. Output is the existence of an element from the login vc
    func testHandleLogout() {
        
    }
    
    ///Test if the back buttons for AddChatVC and RemoteConversationsVC gets us to a new view by checking for the existence of something in the new view as output
    func testBackButtons() {
        let app = XCUIApplication()
        app.buttons["Add"].tap()
        
        let backButton = app.buttons["back"]
        backButton.tap()
        let title = app.staticTexts["Chat"]
        
        XCTAssertTrue(title.exists)
        
        backButton.tap()
        let logo = app.buttons["yo"]
        
        XCTAssertTrue(logo.exists)
    }
}
