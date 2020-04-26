//
//  ViewControllerUITests.swift
//  iASLUITests
//
//  Created by Likhon Gomes on 4/18/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest

class ViewControllerUITests: XCTestCase {
    
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

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    ///Checks the action to go to notes and then get back by pressing buttons
    func testTransitionToNotesAndBack(){
        
        let app = XCUIApplication()
        app.buttons["notesIcon"].tap()
        app.buttons["back"].tap()
        
    }
    
    ///Checks the action to go to contacts and then get back by pressing buttons
    func testTransitionToContactsAndBack(){
        let app = XCUIApplication()
        app.buttons["chatIcon"].tap()
        app.buttons["back"].tap()
        
    }
    
    ///Test output textview expansion and contraction by swiping up and down
    func testExpandAndContractOutputTextView(){
        
        
        let element = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 2)
        element.swipeDown()
        element.children(matching: .textView).element(boundBy: 1).swipeUp()
        
        
        
    }
    
    ///Checks  the dashboard's expandability and contractability by tapping more button
    func testExpandAndContractDashboard(){
        
        let app = XCUIApplication()
        app.buttons["More"].tap()
        app.buttons["Close Dashboard"].tap()
        
    }
    
    ///Check the transition from main view controller to transcription vc by tapping on the live button
    func testTransitionToSpeechToTextAndBackByButtonTap(){
        let app = XCUIApplication()
        app.buttons["yo"].tap()
        app.buttons["Stop Recording"].tap()
    }
    
    ///Check the transition from main view controller to transcription vc by changing device orientation
    func testTransitionToSpeechToTextAndBackByButtonOrientationChange(){
        XCUIDevice.shared.orientation = .landscapeRight
        XCUIDevice.shared.orientation = .portraitUpsideDown
        XCUIDevice.shared.orientation = .landscapeLeft
        XCUIDevice.shared.orientation = .portrait
        
        
    }
    
    ///Test by raising the keyboard and then type and then hit the keybaord button to remove the keybaord
    func testKeyboardExpandibility(){
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Keyboard"]/*[[".buttons[\"Keyboard\"].staticTexts[\"Keyboard\"]",".staticTexts[\"Keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let hKey = app/*@START_MENU_TOKEN@*/.keys["H"]/*[[".keyboards.keys[\"H\"]",".keys[\"H\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hKey.tap()
        app.buttons["ASL"].tap()
        
        
        
    }
    
    ///Test the speak button by tapping it and then listen to the output
    func testSpeakButtonByTapping(){
        
        let app = XCUIApplication()
        app.buttons["Speak"].tap()
        app.buttons["Mute"].tap()
        
        
    }
    
    ///Test slider by swiping it all ways and test the variable change
    func testSliderBySliding(){
        
        
        
        

    }

    ///Test logout button by tapping it and logging out of the app
    func testLogOutButton(){

        let app = XCUIApplication()
//        app/*@START_MENU_TOKEN@*/.staticTexts["Already a user? Login"]/*[[".buttons[\"Already a user? Login\"].staticTexts[\"Already a user? Login\"]",".staticTexts[\"Already a user? Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        let emailTextField = app.textFields["Email Address"]
//        emailTextField.tap()
//        emailTextField.typeText(email)
//
//        let passwordTextField = app.secureTextFields["Password"]
//        passwordTextField.tap()
//        passwordTextField.typeText(password)
//
//        app.buttons["Login"].tap()
//        sleep(5)
        
        app.buttons["More"].tap()
        app.buttons["Log out"].tap()
        
        let logo = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        
        XCTAssertTrue(logo.exists)
        
        let nameTextField = app.textFields["Name"]
        
        XCTAssertTrue(nameTextField.exists)
        
//        XCTAssertTrue(emailTextField.exists)
//
//        XCTAssertTrue(passwordTextField.exists)
        
    }
    
    ///test train button by tapping on it and moving on to Train View Controller
    func testTrainButton(){
        
        let app = XCUIApplication()
        app.buttons["More"].tap()
        app.sliders["50%"]/*@START_MENU_TOKEN@*/.press(forDuration: 1.4);/*[[".tap()",".press(forDuration: 1.4);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app.buttons["Close Dashboard"].tap()
        
        
    }
    
    ///test prediction assist button by turning it on and off and observing it's state
    func testPredictionAssistButton(){
        
    }
    
    ///Test clear button by removing something added to the output text view and then removing them
    func testClearButton(){
        let testText = "This is a test"
        let output = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .textView).element(boundBy: 1)
        XCUIApplication().buttons["Keyboard"].tap()
        output.tap()
        output.typeText(testText)
        XCUIApplication().buttons["Speak"].tap()
        
        
    }
    
    ///Test by swiping right to check if the app transitions to chat view controller
    func testNavigationToChatBySwipingRight(){
        
        
    }
    
    ///Test by swiping right to check if the app transitions to note view controller
    func testNavigationToNotesBySwipingRight(){
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
