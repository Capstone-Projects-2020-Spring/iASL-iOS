//
//  NotesVCUITest.swift
//  iASLUITests
//
//  Created by Liam Miller on 4/18/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest

class NotesVCUITests: XCTestCase {
    
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
        app.buttons["notesIcon"].tap()
    }
    
    override func tearDown() {
        
    }
    
    ///Test if the user is prompted for a deletion note reassurance by checking for an alert
    func testHandleDeleteNoteAreYouSure() {
        
        let app = XCUIApplication()
        
        let table = app.tables.matching(identifier: "testingNotesVCTableView")
        let cell = table.cells.element(matching: .cell, identifier: "notesTableViewCell_0")
        cell.swipeLeft()
        
        //app.tables["testingNotesVCTableView"]/*@START_MENU_TOKEN@*/.staticTexts["09:37 PM"]/*[[".cells[\"remoteTableViewCell_0\"].staticTexts[\"09:37 PM\"]",".staticTexts[\"09:37 PM\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        //app.buttons["back"].tap()
        
        app.tables["testingNotesVCTableView"]/*@START_MENU_TOKEN@*/.buttons["trailing0"]/*[[".cells[\"remoteTableViewCell_0\"]",".buttons[\"Delete\"]",".buttons[\"trailing0\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let popup = app.alerts["This is permanent!"].scrollViews.otherElements.staticTexts["Are you sure you want to delete this?"]
        
        XCTAssertTrue(popup.exists)
    }
    
    ///Test if a note can be dislayed from a table view by checking for the existence of an element from the next view controller
    func testShowNoteFromTableView() {
        let app = XCUIApplication()
        
        let table = app.tables.matching(identifier: "testingNotesVCTableView")
        let cell = table.cells.element(matching: .cell, identifier: "notesTableViewCell_0")
        cell.tap()
        
        let saveButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        
        XCTAssertTrue(saveButton.exists)
        
        app.buttons["back"].tap()
        let notesTitle = app.staticTexts["Notes"]
        
        XCTAssertTrue(notesTitle.exists)
        
    }
    
    ///Test if the create a note button works by seeing if an element in the next view controller exists as output
    func testCreateNoteButtonTapped() {
        
        let app = XCUIApplication()
        
        sleep(5)
        
        app.buttons["New Note"].tap()
        
        
        //app.tables["testingNotesVCTableView"].tap()
        //app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.tap()
        let textView = app.textViews.containing(.staticText, identifier:"Type note here...").element
        //let saveButton = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        
        XCTAssertTrue(textView.exists)
        
        
    }

}
