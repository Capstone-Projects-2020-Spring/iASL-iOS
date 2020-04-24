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
    var note: Note?

    override func setUp() {
        createNotesVC = CreateNoteVC()
        note = nil
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
    
    ///Test if the save button works by testing if the save button gets toggled. Output would be changed text
    func testSaveButtonEnabledAndToggled() {
        createNotesVC?.saveButton.isEnabled = false
        
        createNotesVC?.toggleSaveButtonDisabled()
        
        let disabled = createNotesVC?.saveButton.isEnabled
        
        XCTAssertFalse(disabled!)
        
        createNotesVC?.toggleSaveButtonEnabled()
        
        let enabled = createNotesVC?.saveButton.isEnabled
        
        XCTAssertTrue(enabled!)
    }
    
    ///Test if the note can load another note by tappnig on the table view and seeing if the output has some text was presented in the new VC
    func testLoadNoteWorks() {
        
        createNotesVC?.note = note
        
        createNotesVC?.loadNote()
        
        let text = createNotesVC?.textView.placeholder
        
        XCTAssertEqual(text!, "Type note here...")
        
        //textView.placeholder = "Type note here..."
    }

}
