//
//  PredictionLayer.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 4/15/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

/**
    Prediction layer that helps filter out unnecessary word before it's pushed to the text view. It looks if the current alphabet can generate a word otherwise looks for the best alphabet from the similarity pool and looks to see if any other alphabet from the similarity pool can generate a word, if so then replace the current alphabet with a word generateable alphabet from the pool.
 */
class PredictionLayer {
    ///List of grouped alphabets that look similar to each other.
    let similarAlphabets = [["A","S","E","M","N","T"],
    ["G","H"],
    ["I","J","Y"],
    ["K","P"],
    ["U","V"]]
    
    var word = String()
    var cache = [String]()
    
    init(){}
    
    ///Finds the closest match for the word and ignores alphabet that doesn't match
    func letterProximitySwap(inputWord:String, inputChar:String) -> String {
        var ret = ""
        let index = isSimilarLetter(inputChar: inputChar)
        print("a")
        if index != -1 {
            print("b")
            let predictedWord = fetchPossibleWord(str: inputWord+inputChar)
            if predictedWord?.count != 0 {
                ret = inputChar
                print("c : \(predictedWord)")
            } else {
                for alphabet in similarAlphabets[index] {
                    let predictedWord = fetchPossibleWord(str: inputWord+alphabet)
                    if predictedWord?.count != 0 {
                        print("second if statement: \(predictedWord)")
                        ret = alphabet
                        break
                    }
                }
            }
        } else {
            ret = inputChar
        }
        return ret
    }
    
    
    func fetchPossibleWord(str:String) -> [String]? {
        let rangeForEndOfStr = NSMakeRange(0, str.utf16.count)     // You had inverted parameters ; could also use NSRange(0..<str.utf16.count)
        let spellChecker = UITextChecker()
        //print(UITextChecker.availableLanguages)
        let completions = spellChecker.completions(forPartialWordRange: rangeForEndOfStr, in: str, language: "en_US")!
        //print(completions ?? "No completion found")
        return completions
    }
    
    
    ///Check if the alphabet is one of the designated similar looking alphabet, if so, the function returns the index number.
    ///If -1 the letter does not exist
    func isSimilarLetter(inputChar:String) -> Int {
        var ret = -1
        var iterator = 0
        for alphabetSet in similarAlphabets {
            if alphabetSet.contains(inputChar) {
                ret = iterator
                break
            } else {
                ret = -1
            }
            iterator += 1
        }
        return ret
    }
    
    func clearWord(){
        word = ""
    }
    
    func removeLastLetterFromWord() {
        if word.count != 0 {
            word.removeLast()
        }
    }
}
