//
//  ASLKeyboardTests.swift
//  iASLUITests
//
//  Created by Ian Applebaum on 3/28/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest
import SwiftMonkey
class ASLKeyboardUITests: XCTestCase {
	// FIXME: Fix UI Testing for Github CI/CD
	let application = XCUIApplication(bundleIdentifier: "org.iASL.LanguageTranslator")
	override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		application.launchArguments.append("ui-testing")
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
		application.launch()
		
		var count = 0
		addUIInterruptionMonitor(withDescription: "System Dialog") { (alert) -> Bool in
		  let okButton = alert.buttons["OK"]
		  if okButton.exists {
			okButton.tap()
			count += 1
		  }

		  let allowButton = alert.buttons["Allow"]
		  if allowButton.exists {
			allowButton.tap()
			count += 1
		  }
		  return true
		}
		application.activate()
//		let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
//
//		let alertAllowButton = springboard.buttons.element(boundBy: 1)
//		if alertAllowButton.waitForExistence(timeout: 5) {
//		   alertAllowButton.tap()
//		}
		print(count)
		let validTestUser = "test1@gmail.com"
		let password = "password" //super secret am I right?
	
		let alreadyButton = application/*@START_MENU_TOKEN@*/.staticTexts["Already a user? Login"]/*[[".buttons[\"Already a user? Login\"].staticTexts[\"Already a user? Login\"]",".staticTexts[\"Already a user? Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		alreadyButton.waitForExistence(timeout: 5)
		alreadyButton.tap()
		let emailField = application.textFields["Email Address"]
		emailField.tap()
		emailField.typeText(validTestUser)
		
		let passwordSecureTextField = application.secureTextFields["Password"]
		passwordSecureTextField.tap()
		passwordSecureTextField.typeText(password)

		application.buttons["Login"].tap()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

	override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	
	/// Checks if the keyboard types random things with no camera data.
    func testASLKeyboardLaunchesNoErroneousInput() {
		
		
		
		
		let notes = application.buttons["notesIcon"]
		notes.waitForExistence(timeout: 1)
		notes.tap()
		
		application.buttons["New Note"].tap()
		application.textViews.containing(.staticText, identifier:"Type note here...").element.tap()
		application.buttons["back"].tap()
		

    }

	func testChatScreen() {
		
		let app = XCUIApplication()
		app.buttons["chatIcon"].tap()
		
		
		app.swipeDown()
				
		let liam = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Liam Miller"]/*[[".cells.staticTexts[\"Liam Miller\"]",".staticTexts[\"Liam Miller\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		liam.waitForExistence(timeout: 1)
		liam.tap()
		let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
		textView.waitForExistence(timeout: 1)
		textView.tap()
		let random = UUID()
		textView.typeText("\(random)")
		let verticalScrollBar1PageCollectionView = app/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 1 page").element/*[[".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 1 page\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		verticalScrollBar1PageCollectionView.tap()
		verticalScrollBar1PageCollectionView.tap()
		verticalScrollBar1PageCollectionView.tap()
		app.buttons["send"].tap()
		let helloStaticText = app.collectionViews/*@START_MENU_TOKEN@*/.textViews/*[[".cells.textViews",".textViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["\(random)"]
		helloStaticText.waitForExistence(timeout: 1)
		XCTAssertTrue(helloStaticText.exists)
		
		
		
	}
	
	func testKeyboardDelete() {
		
		let app = XCUIApplication()
		let notes = app.buttons["notesIcon"]
		notes.waitForExistence(timeout: 1)
		notes.tap()
		app.buttons["New Note"].tap()
		let typeNoteHereTextView = app.textViews.containing(.staticText, identifier:"Type note here...").element
		typeNoteHereTextView.waitForExistence(timeout: 1)
		typeNoteHereTextView.tap()
		
		let staticText = app/*@START_MENU_TOKEN@*/.staticTexts["⌫"]/*[[".keys[\"Delete\"].staticTexts[\"⌫\"]",".staticTexts[\"⌫\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		for i in 0..<100{
			print(i)
			staticText.tap()
		}
	
		
	}

//	func testLogin() {
//		
//		let app = XCUIApplication()
//		app.alerts["“iASL” Would Like to Access Speech Recognition"].scrollViews.otherElements.buttons["OK"].tap()
//		
//		let app2 = app
//		app2/*@START_MENU_TOKEN@*/.staticTexts["Continue"]/*[[".buttons[\"Continue\"].staticTexts[\"Continue\"]",".staticTexts[\"Continue\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//		app2/*@START_MENU_TOKEN@*/.staticTexts["Already a user? Login"]/*[[".buttons[\"Already a user? Login\"].staticTexts[\"Already a user? Login\"]",".staticTexts[\"Already a user? Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//		app.textFields["Email Address"].tap()
//		
//		let passwordSecureTextField = app.secureTextFields["Password"]
//		passwordSecureTextField.tap()
//		passwordSecureTextField.tap()
//		app.buttons["Login"].tap()
//		app.alerts["“iASL” Would Like to Access the Camera"].scrollViews.otherElements.buttons["OK"].tap()
//		app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .textView).element.tap()
//		app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//	
//	}
}
