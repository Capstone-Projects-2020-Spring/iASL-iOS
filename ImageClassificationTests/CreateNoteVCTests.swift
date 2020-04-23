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
        let testSuccess = createNotesVC?.handleNewNote(noteText: "note", title: "title", owner: uid)
        
        XCTAssertTrue(testSuccess!)
    }
    
    ///Test if the handle new note is a failure by looking for a variable that represents failure as a result
    func testHandleNewNoteFailure() {
        let testFailure = createNotesVC?.handleNewNote(noteText: "note", title: "title", owner: "")
        
        XCTAssertFalse(testFailure!)
    }
    
    ///Test if the handle update note is successful by looking for a variable that represents success as a result
    func testHandleUpdateNoteSuccess() {
        let key = "key"
        createNotesVC?.noteToUpdateKey = key
        let testSuccess = createNotesVC?.handleUpdateNote(noteText: "note", title: "title", owner: uid)
        
        XCTAssertTrue(testSuccess!)
    }
    
    ///Test if the handle update note is a failure by looking for a variable that represents failure as a result
    func testHandleUpdateNoteFailure() {
        let key = "key"
        createNotesVC?.noteToUpdateKey = key
        let testFailure = createNotesVC?.handleUpdateNote(noteText: "note", title: "title", owner: "")
        
        XCTAssertFalse(testFailure!)
    }
    
    ///Test if the handle update note is a failure by looking for a variable that represents failure as a result
    func testHandleUpdateNoteFailureNoKey() {
        let testFailure = createNotesVC?.handleUpdateNote(noteText: "note", title: "title", owner: uid)
        
        XCTAssertFalse(testFailure!)
    }

}
