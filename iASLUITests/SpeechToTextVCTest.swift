//
//  SpeechToTextVCTest.swift
//  iASLUITests
//
//  Created by Likhon Gomes on 4/26/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest

class SpeechToTextVCTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        XCUIApplication().launch()
        XCUIApplication().buttons["yo"].tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGoingBackToTheMainViewControllerByButtonTap(){
        XCUIApplication().buttons["Stop Recording"].tap()
        
        
    }
    
    func testGoingBackToTheMainViewControllerByOrientationChange(){
        XCUIDevice.shared.orientation = .landscapeRight
        XCUIDevice.shared.orientation = .portraitUpsideDown
        XCUIDevice.shared.orientation = .landscapeLeft
        XCUIDevice.shared.orientation = .portrait
        
        
        

        
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        //self.measure {
            // Put the code you want to measure the time of here.
        //}
    }

}
