//
//  ASLtoText.swift
//  ImageClassification
//
//  Created by Ian Applebaum on 3/24/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
protocol ASLViewControllerDelegate {
	var outputDelegate: UIView? { get set }
}
/// Functions for ASL to Text recognition
protocol ASLtoTextEditing {
	/// deletes the last charachter
	func deleteCharacter()
	/// Executes functions based off of Classifier output.
	func iASLClassifier()
	/// adds word result to text
	func addWord()
	/// add charachter result to text
	func addCharachter()
	/// moves cursor one charachter forward.
	func moveCursorForward()
	/// moves cursor one charachter backward.
	func moveCursorBackward()
	/// deletes the whole line of text.
	func deleteLine()
	/// deletes the last word of the line.
	func deleteLastWord()
	/// adds \n newline to text.
	func newLine()
	/// selects the word at current cursor position.
	func selectWord()
	/// selects entire line of text
	func selectLine()
	/// begins selection of text
	func startSelect()
	/// ends the current text selection
	func endSelect()
	/// deselects current selection
	func deselectAll()
	/// starts deselecting at cursor point
	func startDeselect()
	/// stops deselecting at cursor point
	func endDeselect()
	
}

protocol ASLPunctuation {
	/// adds " " to text.
	func addSpace()
	func addPeriod()
	func addComma()
	func addSemiColon()
}
