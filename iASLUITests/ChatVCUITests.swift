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
    
    ///This will test if the message that was sent from the user is pink. Output is a matching color
    func testIfSentMessageIsPink() {
        let app = XCUIApplication()

        let collectionViewsQuery = app.collectionViews
        //collectionViewsQuery.children(matching: .cell).element(boundBy: 18).children(matching: .textView).element.tap()
        let receivedMessage = collectionViewsQuery/*@START_MENU_TOKEN@*/.textViews.containing(.staticText, identifier:"Lpp").element/*[[".cells.textViews.containing(.staticText, identifier:\"Lpp\").element",".textViews.containing(.staticText, identifier:\"Lpp\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        print(receivedMessage.textFields)
        
    }
    
    ///This will test if the message that was sent from the partner is gray. Output is a matching color
    func testIfReceivedMessageIsPink() {
        //collectionViewsQuery/*@START_MENU_TOKEN@*/.textViews/*[[".cells.textViews",".textViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Hello"].tap()
        //app.staticTexts["Liam Miller"].tap()
        //app.buttons["back"].tap()
    }
    
    ///This will test if a message sends and appears in the chatVC. Output is the existence of a message bubble
    func testMessageSent() {
        
    }
    
    ///Checks if the keyboard goes away if you tap somewhere else on the screen. Output is a boolean variable defining success
    func testIfKeyboardDisappearsOnTappedElsewhere() {
        
    }

}
