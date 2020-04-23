//
//  CreateNoteVCTests.swift
//  ImageClassificationTests
//
//  Created by Liam Miller on 4/18/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest
@testable import iASL

class CreateNoteVCTests: XCTestCase {
    
    let partner = "bill_id"
    
    //need to sign in
    let email = "Test1@gmail.com"
    let password = "password"
    let uid = "ppmK3FXm7gPc6HwhS5wOvBtfLFP2"
    
    var createNotesVC: CreateNoteVC?

    override func setUp() {
        createNotesVC = CreateNoteVC()
    }
    
    override func tearDown() {
        
    }
    
    ///Test if the handle new note is successful by looking for a variable that represents success as a result
    func testHandleNewNoteSuccess() {
        
    }
    
    ///Test if the handle new note is a failure by looking for a variable that represents failure as a result
    func testHandleNewNoteFailure() {
        
    }
    
    ///Test if the handle update note is successful by looking for a variable that represents success as a result
    func testHandleUpdateNoteSuccess() {
        
    }
    
    ///Test if the handle update note is a failure by looking for a variable that represents failure as a result
    func testHandleUpdateNoteFailure() {
        
    }

}
