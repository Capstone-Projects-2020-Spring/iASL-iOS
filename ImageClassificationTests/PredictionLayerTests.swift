//
//  PredictionLayerTests.swift
//  ImageClassificationTests
//
//  Created by Likhon Gomes on 4/18/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import XCTest
@testable import iASL

class PredictionLayerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    

    ///Tests the letter proximity swap function by letting the
    func testLetterProximitySwap(){
        let predictionLayer = PredictionLayer()
        predictionLayer.letterProximitySwap(inputWord: "T", inputChar: "T")
        assert(predictionLayer.letterProximitySwap(inputWord: "T", inputChar: "T") == "A", "Letter Proximity Passed")
        assert(predictionLayer.letterProximitySwap(inputWord: "T", inputChar: "A") == "A", "Letter Proximity Passed")
    }
    
    ///Inputs two sets of alphabets, one with similar proximity and no proximity, the test should pass if the alphabets with similarities return with an index between 0 - 4 and non similar alphabets should return -1
    func testIsSimilarLetter(){
        let predictionLayer = PredictionLayer()
        predictionLayer.isSimilarLetter(inputChar: "A")
        assert(predictionLayer.isSimilarLetter(inputChar: "A") == 0, "Test Passed")
        assert(predictionLayer.isSimilarLetter(inputChar: "Z") == -1, "Test Passed")
        assert(predictionLayer.isSimilarLetter(inputChar: "G") == 1, "Test Passed")
        assert(predictionLayer.isSimilarLetter(inputChar: "A") != 1, "Test Passed")
        assert(predictionLayer.isSimilarLetter(inputChar: "I") == 2, "Test Passed")
        assert(predictionLayer.isSimilarLetter(inputChar: "K") == 3, "Test Passed")
        assert(predictionLayer.isSimilarLetter(inputChar: "U") == 4, "Test Passed")
    }
    
    ///Inputs two sets of words, one with incomplete words, the test should pass if the function return a known completed word with an index between 0 - 4 and absolute non sense words should return nil
    func testFetchPossibleWord(){
        let predictionLayer = PredictionLayer()
        assert(predictionLayer.fetchPossibleWord(str: "wo") != nil, "Fetch possible word Test Passed")
        assert(predictionLayer.fetchPossibleWord(str: "ccccc") == [], "Fetch possible word Test Passed")
        assert(predictionLayer.fetchPossibleWord(str: "wo")![0] == "would", "Fetch possible word Test Passed")
    }
    
    
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
