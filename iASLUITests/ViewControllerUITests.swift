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
        let app = XCUIApplication()
        app.launch()
        let textView = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .textView).element
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
        let textview = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .textView).element
        
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Keyboard"]/*[[".buttons[\"Keyboard\"].staticTexts[\"Keyboard\"]",".staticTexts[\"Keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let gKey = app/*@START_MENU_TOKEN@*/.keys["G"]/*[[".keyboards.keys[\"G\"]",".keys[\"G\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        gKey.tap()
        gKey.tap()
        
        let hKey = app/*@START_MENU_TOKEN@*/.keys["h"]/*[[".keyboards.keys[\"h\"]",".keys[\"h\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hKey.tap()
        hKey.tap()
        hKey.tap()
        
        let gKey2 = app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        gKey2.tap()
        gKey2.tap()
        hKey.tap()
        hKey.tap()
        app.buttons["ASL"].tap()
        
        
        
    }
    
    ///Test the speak button by tapping it and then listen to the output
    func testSpeakButtonByTapping(){
        
        let app = XCUIApplication()
        app.launch()
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .textView).element
        textView.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Keyboard"]/*[[".buttons[\"Keyboard\"].staticTexts[\"Keyboard\"]",".staticTexts[\"Keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        textView.tap()
        app.buttons["ASL"].tap()
        
    }
    
    ///Test slider by swiping it all ways and test the variable change
    func testSliderBySliding(){
        
        
        let app = XCUIApplication()
        app.launch()
        app/*@START_MENU_TOKEN@*/.staticTexts["More"]/*[[".buttons[\"More\"].staticTexts[\"More\"]",".staticTexts[\"More\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sliders["50%"].swipeRight()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2)
        element/*@START_MENU_TOKEN@*/.press(forDuration: 2.0);/*[[".tap()",".press(forDuration: 2.0);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        element.swipeLeft()
        

    }

    ///Test logout button by tapping it and logging out of the app
    func testLogOutButton(){
 
        
    }
    
    ///test train button by tapping on it and moving on to Train View Controller
    func testTrainButton(){
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["More"].tap()
        let helpUsLearnAslStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Help Us Learn ASL"]/*[[".buttons[\"Help Us Learn ASL\"].staticTexts[\"Help Us Learn ASL\"]",".staticTexts[\"Help Us Learn ASL\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        helpUsLearnAslStaticText.tap()
        helpUsLearnAslStaticText.tap()
        
        
    }
    
    ///test prediction assist button by turning it on and off and observing it's state
    func testPredictionAssistButton(){
        
    }
    
    ///Test clear button by removing something added to the output text view and then removing them
    func testClearButton(){
        
        let app = XCUIApplication()
        app.launch()
        let textToInput = "Hello this is a test"
        DispatchQueue.main.async {
            let outputTextView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .textView).element
            outputTextView.typeText(textToInput)
        }
        
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
