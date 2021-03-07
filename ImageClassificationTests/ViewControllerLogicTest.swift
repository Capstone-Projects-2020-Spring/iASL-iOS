//
//  ViewControllerLogicTest.swift
//  ImageClassificationTests
//
//  Created by Likhon Gomes on 4/18/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest
@testable import iASL
class ViewControllerLogicTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    /**
    Tests ASL Finger Spelling text insertion. Classifies and image that is clearly the letter V.
    */
    func testAddASLText() {

         let image = #imageLiteral(resourceName: "V")
         guard let buffer = CVImageBuffer.buffer(from: image) else {
             return
         }
        
    }

}
