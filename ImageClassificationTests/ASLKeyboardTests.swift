//
//  ASLKeyboardTests.swift
//  ImageClassificationTests
//
//  Created by Ian Applebaum on 3/28/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest
@testable import iASL
class ASLKeyboardTests: XCTestCase {
	var noteVC: CreateNoteVC?
	let previewView = PreviewView()
	override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		noteVC = CreateNoteVC()
		noteVC?.textView.text = "T"
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	///Tests whether the keyboard can delete a charachter from the text view.
    func testKeyboardDelete() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		let keyboard = CameraBoard(target: noteVC!.textView)
		noteVC?.textView.inputView = keyboard
		DispatchQueue.main.async {
			keyboard.deleteChar {

				XCTAssert(keyboard.target!.hasText == false, "Has text")
			}
		}

    }
	/// Tests whether the next key can add a newline to the textview
	func testTestAddReturn() {
		let keyboard = CameraBoard(target: noteVC!.textView)
		noteVC?.textView.inputView = keyboard
		DispatchQueue.main.async {
			keyboard.returnKeyPressed()
			keyboard.returnKeyPressed()
			keyboard.returnKeyPressed()
			keyboard.returnKeyPressed()
			keyboard.returnKeyPressed()
			XCTAssert(self.noteVC?.textView.text! == "T\n\n\n\n\n", "Return key pressed failed. Text = \(String(describing: self.noteVC?.textView.text!))")
		}
	}
	/**
	Tests ASL Finger Spelling text insertion. Classifies and image that is clearly the letter V.
	*/
	func testAddASLText() {
		let keyboard = CameraBoard(target: noteVC!.textView)
		noteVC?.textView.inputView = keyboard
		let image = #imageLiteral(resourceName: "V")
		guard let buffer = CVImageBuffer.buffer(from: image) else {
            return
        }
        DispatchQueue.main.async {
			keyboard.didOutput(pixelBuffer: buffer)
			XCTAssert(self.noteVC?.textView.text! == "TV", "V was not inserted to textview. Text = \(String(describing: self.noteVC?.textView.text!))")
        }
	}
	///This test just tests the pasteboard classifier in debugging.
	func testClassifyPasteboard(){
		let keyboard = CameraBoard(target: noteVC!.textView)
		noteVC?.textView.inputView = keyboard
		let image = #imageLiteral(resourceName: "V")
		let pasteBoard = UIPasteboard.general
		pasteBoard.image = image
        DispatchQueue.main.async {
			keyboard.classifyPasteboardImage()
			XCTAssert(self.noteVC?.textView.text! == "TV", "Pasteboard wasnt clasified. failed. Text = \(String(describing: self.noteVC?.textView.text!))")
        }
	}
}
