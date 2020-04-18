//
//  MonkeyTests.swift
//  iASLUITests
//
//  Created by Ian Applebaum on 4/17/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest
import SwiftMonkey
class MonkeyTests: XCTestCase {
	let application = XCUIApplication()
	override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
         // Put setup code here. This method is called before the invocation of each test method in the class.
				application.launchArguments.append("ui-testing")
		application.launchArguments.append("monkeyTesting")
				// In UI tests it is usually best to stop immediately when a failure occurs.
				continueAfterFailure = false
				// UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
				application.launch()
				
				

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

	override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testMonkeyFromLogin() {

	//		application.launchArguments = ["--MonkeyPaws"]
			
			addUIInterruptionMonitor(withDescription: "System Dialog") { (alert) -> Bool in
				  let okButton = alert.buttons["OK"]
				  if okButton.exists {
					okButton.tap()
				  }

				  let allowButton = alert.buttons["Allow"]
				  if allowButton.exists {
					allowButton.tap()
				  }

				  return true
				}
				// Initialise the monkey tester with the current device
				// frame. Giving an explicit seed will make it generate
				// the same sequence of events on each run, and leaving it
				// out will generate a new sequence on each run.
				let monkey = Monkey(frame: XCUIApplication().frame)
				//let monkey = Monkey(seed: 123, frame: application.frame)

				// Add actions for the monkey to perform. We just use a
				// default set of actions for this, which is usually enough.
				// Use either one of these but maybe not both.

				// XCTest private actions seem to work better at the moment.
				// before Xcode 10.1, you can use
				// monkey.addDefaultXCTestPrivateActions()

				// after Xcode 10.1 We can only use public API
			monkey.addDefaultUIAutomationActions()

				// UIAutomation actions seem to work only on the simulator.
				//monkey.addDefaultUIAutomationActions()

				// Occasionally, use the regular XCTest functionality
				// to check if an alert is shown, and click a random
				// button on it.
	//			monkey.addXCTestTapAlertAction(interval: 100, application: XCUIApplication())

				// Run the monkey test indefinitely.
			monkey.monkeyAround(forDuration: 100)
		}
	///Monkey test from the chat screen.
	func testMonkeyChat() {
		
				addUIInterruptionMonitor(withDescription: "System Dialog") { (alert) -> Bool in
				  let okButton = alert.buttons["OK"]
				  if okButton.exists {
					okButton.tap()
					
				  }

				  let allowButton = alert.buttons["Allow"]
				  if allowButton.exists {
					allowButton.tap()
					
				  }
				  return true
				}
				application.activate()
				
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
		XCUIApplication().buttons["chatIcon"].tap()
				
		// Initialise the monkey tester with the current device
					// frame. Giving an explicit seed will make it generate
					// the same sequence of events on each run, and leaving it
					// out will generate a new sequence on each run.
					let monkey = Monkey(frame: XCUIApplication().frame)
					//let monkey = Monkey(seed: 123, frame: application.frame)

					// Add actions for the monkey to perform. We just use a
					// default set of actions for this, which is usually enough.
					// Use either one of these but maybe not both.

					// XCTest private actions seem to work better at the moment.
					// before Xcode 10.1, you can use
					// monkey.addDefaultXCTestPrivateActions()

					// after Xcode 10.1 We can only use public API
				monkey.addDefaultUIAutomationActions()

					// UIAutomation actions seem to work only on the simulator.
					//monkey.addDefaultUIAutomationActions()

					// Occasionally, use the regular XCTest functionality
					// to check if an alert is shown, and click a random
					// button on it.
		//			monkey.addXCTestTapAlertAction(interval: 100, application: XCUIApplication())

					// Run the monkey test indefinitely.
				monkey.monkeyAround(forDuration: 100)
		
	}
	///Monkey test from notes.
	func testMonkeyNotes() {
		
	}
	///Monkey test from the main view controller.
	func testMonkeyMainView() {
		
	}
}
