//
//  ViewControllerUITests.swift
//  iASLUITests
//
//  Created by Likhon Gomes on 4/18/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest

class ViewControllerUITests: XCTestCase {

    override func setUp() {
        let app = XCUIApplication()
        app.launch()

        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    ///Checks the action to go to notes and then get back by pressing buttons
    func testTransitionToNotesAndBack(){
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["notesIcon"].tap()
        app.buttons["back"].tap()
        
    }
    
    ///Checks the action to go to contacts and then get back by pressing buttons
    func testTransitionToContactsAndBack(){
        let app = XCUIApplication()
        app.launch()
        app.buttons["chatIcon"].tap()
        app.buttons["back"].tap()
        
    }
    
    ///Test output textview expansion and contraction by swiping up and down
    func testExpandAndContractOutputTextView(){
        
        let textView = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .textView).element(boundBy: 1)
        textView.swipeDown()
        textView.swipeUp()
        
        
    }
    
    ///Checks  the dashboard's expandability and contractability by tapping more button
    func testExpandAndContractDashboard(){
        
        let app = XCUIApplication()
        app.launch()
        app/*@START_MENU_TOKEN@*/.staticTexts["More"]/*[[".buttons[\"More\"].staticTexts[\"More\"]",".staticTexts[\"More\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
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
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .textView).element(boundBy: 1)
        textView.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Keyboard"]/*[[".buttons[\"Keyboard\"].staticTexts[\"Keyboard\"]",".staticTexts[\"Keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["D"]/*[[".keyboards.keys[\"D\"]",".keys[\"D\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let dKey = app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dKey.tap()
        dKey.tap()
        textView.tap()
        textView.tap()
        
                        
        
        
    }
    
    ///Test slider by swiping it all ways and test the variable change
    func testSliderBySliding(){
        
        
        
        

    }

    ///Test logout button by tapping it and logging out of the app
    func testLogOutButton(){
 
        
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
        
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Keyboard"]/*[[".buttons[\"Keyboard\"].staticTexts[\"Keyboard\"]",".staticTexts[\"Keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let dKey = app/*@START_MENU_TOKEN@*/.keys["D"]/*[[".keyboards.keys[\"D\"]",".keys[\"D\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
                dKey.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .textView).element(boundBy: 1).tap()
        XCUIApplication().buttons["Clear"].tap()
       
        
        
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
