//
//  ChatVCUITests.swift
//  iASLUITests
//
//  Created by Liam Miller on 4/18/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest

class ChatVCUITests: XCTestCase {
    
    let partner = "bill_id"
    
    //need to sign in
    let email = "Test1@gmail.com"
    let password = "password"
    let uid = "ppmK3FXm7gPc6HwhS5wOvBtfLFP2"

    
    override func setUp() {
        //
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
        app.buttons["chatIcon"].tap()
        //tap on table view
        let table = app.tables.matching(identifier: "testingRemoteVCTableView")
        let cell = table.cells.element(matching: .cell, identifier: "remoteTableViewCell_0")
        cell.tap()
    }
    
    override func tearDown() {
        //
    }
    
    ///This will test if the collection view is able to load. Output is the existence of a cell in the collection view
    func testIfCollectionViewLoads() {
        
        let app = XCUIApplication()

        let collectionViewsQuery = app.collectionViews
        
        XCTAssertTrue(collectionViewsQuery.element.exists)
        
    }
    
    ///This will test if a message sends and appears in the chatVC. Output is the existence of a message bubble
    func testMessageSent() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 9).children(matching: .other).element(boundBy: 0).tap()
        
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        textView.tap()
        textView.tap()
        
        //need to increase this count each time we test
        textView.typeText("Testing a message")
        
        let sendButton = app.buttons["send"]
        sendButton.tap()
        sendButton.tap()
        let newestMessage = collectionViewsQuery/*@START_MENU_TOKEN@*/.textViews/*[[".cells.textViews",".textViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Testing a message"]
        
        sleep(10)
        
        XCTAssertTrue(newestMessage.exists)
        
    }
    
    ///Checks if the keyboard goes away if you tap somewhere else on the screen. Output is a boolean variable defining success
    func testIfKeyboardDisappearsOnTappedElsewhere() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 9).children(matching: .other).element(boundBy: 0).tap()
        
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        textView.tap()
        textView.tap()
        
        
        let keyboard1Button = app.buttons["keyboard 1"]
        keyboard1Button.tap()
        keyboard1Button.tap()
        
        sleep(10)
        
        //XCTAssertEqual(app.keyboards.count, 1) //keyboard exists
        XCTAssertEqual(app.keyboards.count, 0) //keyboard does not exist
    }
    
    func testKeyboardAppearsOnTap() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 9).children(matching: .other).element(boundBy: 0).tap()
        
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        textView.tap()
        textView.tap()
        
        sleep(10)
        
        //XCTAssertEqual(app.keyboards.count, 1) //keyboard exists
        XCTAssertEqual(app.keyboards.count, 0) //keyboard does not exist
    }

}
