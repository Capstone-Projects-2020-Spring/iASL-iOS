//
//  NotesVCTests.swift
//  ImageClassificationTests
//
//  Created by Liam Miller on 4/18/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest
@testable import iASL

class NotesVCTests: XCTestCase {
    
    let partner = "bill_id"
    
    //need to sign in
    let email = "Test1@gmail.com"
    let password = "password"
    let uid = "ppmK3FXm7gPc6HwhS5wOvBtfLFP2"
    
    var notesVC: NotesVC?

    override func setUp() {
        notesVC = NotesVC()
    }
    
    override func tearDown() {
        
    }
    
    ///Test if the observe user notes function can run by looking for a boolean that represents success as a result
    func testObserveUserNotesSuccess() {
        let testSuccess = notesVC?.observeUserNotes(uid: uid)
        
        XCTAssertTrue(testSuccess!)
    }
    
    ///Test if the observe user notes function can fail by looking for a boolean that represents failure as a result
    func testObserveUserNotesFailure() {
        let testFailure = notesVC?.observeUserNotes(uid: "")
        
        XCTAssertFalse(testFailure!)
    }
    
    ///Test if the user can delete a note. Output is a boolean representing a successful test
    func testHandleDeleteNoteSuccess() {
        let testDeleteNote = notesVC?.handleDeleteNote(noteId: "note", uid: uid)
        
        XCTAssertTrue(testDeleteNote!)
    }
    
    ///Test if the user fails to delete a note. Output is a boolean representing a failed test
    func testHandleDeleteNoteFailure() {
        let testDeleteNote = notesVC?.handleDeleteNote(noteId: "note", uid: "")
        
        XCTAssertFalse(testDeleteNote!)
    }

}
