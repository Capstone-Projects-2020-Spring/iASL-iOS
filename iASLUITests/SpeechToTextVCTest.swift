//
//  SpeechToTextVCTest.swift
//  iASLUITests
//
//  Created by Likhon Gomes on 4/26/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest

class SpeechToTextVCTest: XCTestCase {

    let partner = "bill_id"
    
    //need to sign in
    let email = "Test1@gmail.com"
    let password = "password"
    let uid = "ppmK3FXm7gPc6HwhS5wOvBtfLFP2"

    
    
    override func setUpWithError() throws {
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
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGoingBackToTheMainViewControllerByButtonTap(){
        
        let app = XCUIApplication()
        app.buttons["yo"].tap()
        app.buttons["Stop Recording"].tap()
                
    }
    
    func testGoingBackToTheMainViewControllerByOrientationChange(){
        XCUIDevice.shared.orientation = .landscapeRight
        XCUIDevice.shared.orientation = .portraitUpsideDown
        XCUIDevice.shared.orientation = .landscapeLeft
        XCUIDevice.shared.orientation = .portrait
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        //self.measure {
            // Put the code you want to measure the time of here.
        //}
    }

}
