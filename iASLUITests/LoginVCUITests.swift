//
//  LoginVCUITest.swift
//  iASLUITests
//
//  Created by Liam Miller on 4/18/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest

class LoginVCUITests: XCTestCase {
    
    let partner = "bill_id"
    
    //need to sign in
    let email = "Test1@gmail.com"
    let password = "password"
    let uid = "ppmK3FXm7gPc6HwhS5wOvBtfLFP2"

    override func setUp() {
        XCUIApplication().launch()
        
        var count = 0
        addUIInterruptionMonitor(withDescription: "System Dialog") { (alert) -> Bool in
          let okButton = alert.buttons["OK"]
          if okButton.exists {
            okButton.tap()
            count += 1
          }

          let allowButton = alert.buttons["Allow"]
          if allowButton.exists {
            allowButton.tap()
            count += 1
          }
          return true
        }
        
        
    }
    
    override func tearDown() {
        
    }
    
    ///Test if the user can leave the login screen. Output is the existence of an element in the next view controller
    func testHandleLeaveLogin() {
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Already a user? Login"]/*[[".buttons[\"Already a user? Login\"].staticTexts[\"Already a user? Login\"]",".staticTexts[\"Already a user? Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Skip for now"]/*[[".buttons[\"Skip for now\"].staticTexts[\"Skip for now\"]",".staticTexts[\"Skip for now\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let yoButton = app.buttons["yo"]
        
        XCTAssertTrue(yoButton.exists)
    }
    
    ///Test if the register button can be toggled. Output is the existence of new text in the toggle button
    func testToggleRegisterLoginButtonPressed() {
        
        let app = XCUIApplication()
        
        //name text field should exist
        let nameTextField = app.textFields["Name"]
        XCTAssertTrue(nameTextField.exists)
        app/*@START_MENU_TOKEN@*/.staticTexts["Already a user? Login"]/*[[".buttons[\"Already a user? Login\"].staticTexts[\"Already a user? Login\"]",".staticTexts[\"Already a user? Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //name text field should not exist
        XCTAssertFalse(nameTextField.exists)
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Not a user? Register"]/*[[".buttons[\"Not a user? Register\"].staticTexts[\"Not a user? Register\"]",".staticTexts[\"Not a user? Register\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //name text field should exist again
        XCTAssertTrue(nameTextField.exists)
        
    }
    
    ///Test if the button works to submit the info for login. Output is the existence of an element in the next view controller
    func testInfoSubmitButtonPressed() {
        
        let app = XCUIApplication()
        let registerButton = app/*@START_MENU_TOKEN@*/.staticTexts["Register"]/*[[".buttons[\"Register\"].staticTexts[\"Register\"]",".staticTexts[\"Register\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(registerButton.exists)
        registerButton.tap()
        
        let switchButton1 = app/*@START_MENU_TOKEN@*/.staticTexts["Already a user? Login"]/*[[".buttons[\"Already a user? Login\"].staticTexts[\"Already a user? Login\"]",".staticTexts[\"Already a user? Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(switchButton1.exists)
        switchButton1.tap()
        
        let loginButton = app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(loginButton.exists)
        
    }
    
    ///Test if the user can register. Output is the existence of a boolean representing a successful pass
    func testHandleRegister() {
        
        let app = XCUIApplication()
        let nameTextField = app.textFields["Name"]
        nameTextField.tap()
        //nameTextField.typeText("Test Name")
        
        let emailAddressTextField = app.textFields["Email Address"]
        emailAddressTextField.tap()
        //emailAddressTextField.typeText("testemail@test.com")
        
        let passwordTextField = app.secureTextFields["Password"]
        passwordTextField.tap()
        //passwordTextField.typeText("password")
        
        app.buttons["Register"].tap()
        
        let yoButton = app.buttons["yo"]
        
        XCTAssertFalse(yoButton.exists)
        
    }
    
    ///Test if the user can login. Output is the existence of a boolean representing a successful pass
    func testHandleLogin() {
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
        
        //everything past this point is after the user has logged in
        let yoButton = app.buttons["yo"]
        
        XCTAssertTrue(yoButton.exists)
    }
    
    ///Test if the skip button works. Output is the existence of an element in the next view controller
    func testSkipButton() {
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Skip for now"]/*[[".buttons[\"Skip for now\"].staticTexts[\"Skip for now\"]",".staticTexts[\"Skip for now\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let yoButton = app.buttons["yo"]
        
        XCTAssertTrue(yoButton.exists)
        
    }

}
