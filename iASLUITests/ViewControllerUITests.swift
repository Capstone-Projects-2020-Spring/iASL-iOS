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
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
        
        let textView = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .textView).element
        textView.swipeDown()
        textView/*@START_MENU_TOKEN@*/.swipeUp()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        
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

        
    }
    
    ///Test by raising the keyboard and then type and then hit the keybaord button to remove the keybaord
    func testKeyboardExpandibility(){
    
        
    }
    
    ///Test the speak button by tapping it and then listen to the output
    func testSpeakButtonByTapping(){
        
    }
    
    ///Test slider by swiping it all ways and test the variable change
    func testSliderBySliding(){
        
        let app = XCUIApplication()
        let slider = app.sliders["50%"]
        slider.tap()
        slider.swipeRight()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 2)
        element.swipeLeft()
        element.swipeRight()
        app.sliders["0%"].swipeRight()
        app.sliders["3%"].swipeRight()
        
 
    }

    ///Test logout button by tapping it and logging out of the app
    func testLogOutButton(){
        XCUIApplication().buttons["Log out"].tap()
        
    }
    
    ///test train button by tapping on it and moving on to Train View Controller
    func testTrainButton(){
        XCUIApplication().buttons["Help Us Learn ASL"].tap()
    }
    
    ///test prediction assist button by turning it on and off and observing it's state
    func testPredictionAssistButton(){
        
        let app = XCUIApplication()
        app.buttons["Prediction Assist: on"].tap()
        app.buttons["Prediction Assist: off"].tap()
        
    }
    
    ///Test clear button by removing something added to the output text view and then removing them
    func testClearButton(){
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
