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

	override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

	override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	func testMonkey() {
		let application = XCUIApplication()

		application.launchArguments = ["--MonkeyPaws"]

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
			let monkey = Monkey(frame: application.frame)
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
			monkey.addXCTestTapAlertAction(interval: 100, application: application)

			// Run the monkey test indefinitely.
		monkey.monkeyAround(forDuration: 100)
	}
    func testASLKeyboardLaunchesNoErroneousInput() {
        // Use recording to get started writing UI tests.

        // Use XCTAssert and related functions to verify your tests produce the correct results.
		let app = XCUIApplication()
		addUIInterruptionMonitor(withDescription: "System Dialog") {
		  (alert) -> Bool in
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
		app.buttons["notesIcon"].tap()
		app.buttons["New Note"].tap()
		app.textViews.element.tap()
		let text = app.textViews.element.value as? String
		sleep(5)
		XCTAssert(text == "", "Should be blank")

		//Test delete key
		app.keys["Delete"].tap()

    }

}
