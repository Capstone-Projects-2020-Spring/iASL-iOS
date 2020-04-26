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
        // Put setup code here. This method is called before the invocation of each test method in the class.
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    ///Checks the action to go to notes and then get back by pressing buttons
    func testTransitionToNotesAndBack(){
        
    }
    
    ///Checks the action to go to contacts and then get back by pressing buttons
    func testTransitionToContactsAndBack(){
        
    }
    
    ///Test output textview expansion and contraction by swiping up and down
    func testExpandAndContractOutputTextView(){
        
    }
    
    ///Checks  the dashboard's expandability and contractability by tapping more button
    func testExpandAndContractDashboard(){
        
    }
    
    ///Check the transition from main view controller to transcription vc by tapping on the live button
    func testTransitionToSpeechToTextAndBackByButtonTap(){
        
    }
    
    ///Check the transition from main view controller to transcription vc by changing device orientation
    func testTransitionToSpeechToTextAndBackByButtonOrientationChange(){
        
    }
    
    ///Test by raising the keyboard and then type and then hit the keybaord button to remove the keybaord
    func testKeyboardExpandibility(){
        
    }
    
    ///Test the speak button by tapping it and then listen to the output
    func testSpeakButtonByTapping(){
        
    }
    
    ///Test slider by swiping it all ways and test the variable change
    func testSliderBySliding(){
        
    }

    ///Test logout button by tapping it and logging out of the app
    func testLogOutButton(){
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
        
        app.buttons["More"].tap()
        app.buttons["Log out"].tap()
        
        let logo = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        
        XCTAssertTrue(logo.exists)
        
        let nameTextField = app.textFields["Name"]
        
        XCTAssertTrue(nameTextField.exists)
        
        XCTAssertTrue(emailTextField.exists)
        
        XCTAssertTrue(passwordTextField.exists)
        
    }
    
    ///test train button by tapping on it and moving on to Train View Controller
    func testTrainButton(){
        
    }
    
    ///test prediction assist button by turning it on and off and observing it's state
    func testPredictionAssistButton(){
        
    }
    
    ///Test clear button by removing something added to the output text view and then removing them
    func testClearButton(){
        
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
