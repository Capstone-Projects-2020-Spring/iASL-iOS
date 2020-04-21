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
        
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Keyboard"]/*[[".buttons[\"Keyboard\"].staticTexts[\"Keyboard\"]",".staticTexts[\"Keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let hKey = app/*@START_MENU_TOKEN@*/.keys["H"]/*[[".keyboards.keys[\"H\"]",".keys[\"H\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hKey.tap()
        hKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        eKey.tap()
        
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        lKey.tap()
        lKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        oKey.tap()
        
        let spaceKey = app/*@START_MENU_TOKEN@*/.keys["space"]/*[[".keyboards.keys[\"space\"]",".keys[\"space\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        spaceKey.tap()
        spaceKey.tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        tKey.tap()
        
        let hKey2 = app/*@START_MENU_TOKEN@*/.keys["h"]/*[[".keyboards.keys[\"h\"]",".keys[\"h\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hKey2.tap()
        hKey2.tap()
        
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        iKey.tap()
        
        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        sKey.tap()
        spaceKey.tap()
        spaceKey.tap()
        iKey.tap()
        iKey.tap()
        sKey.tap()
        sKey.tap()
        spaceKey.tap()
        spaceKey.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        aKey.tap()
        spaceKey.tap()
        spaceKey.tap()
        tKey.tap()
        tKey.tap()
        eKey.tap()
        eKey.tap()
        sKey.tap()
        sKey.tap()
        tKey.tap()
        tKey.tap()
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
        app.children(matching: .window).element(boundBy: 4).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.tap()
        

        app/*@START_MENU_TOKEN@*/.staticTexts["Keyboard"]/*[[".buttons[\"Keyboard\"].staticTexts[\"Keyboard\"]",".staticTexts[\"Keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let hKey = app/*@START_MENU_TOKEN@*/.keys["H"]/*[[".keyboards.keys[\"H\"]",".keys[\"H\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hKey.tap()
        hKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        eKey.tap()
        
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        lKey.tap()
        lKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        oKey.tap()
        app.buttons["ASL"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Clear"]/*[[".buttons[\"Clear\"].staticTexts[\"Clear\"]",".staticTexts[\"Clear\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
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
