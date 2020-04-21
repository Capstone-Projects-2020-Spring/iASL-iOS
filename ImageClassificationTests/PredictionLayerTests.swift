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
    }
    
    ///Inputs two sets of alphabets, one with similar proximity and no proximity, the test should pass if the alphabets with similarities return with an index between 0 - 4 and non similar alphabets should return -1
    func testIsSimilarLetter(){
        let predictionLayer = PredictionLayer()
        predictionLayer.isSimilarLetter(inputChar: "a")
        assert(predictionLayer.isSimilarLetter(inputChar: "a") == 0, "Test Passed")
        assert(predictionLayer.isSimilarLetter(inputChar: "z") == -1, "Test Passed")
        assert(predictionLayer.isSimilarLetter(inputChar: "g") == 1, "Test Passed")
        assert(predictionLayer.isSimilarLetter(inputChar: "a") != 1, "Test Passed")
        assert(predictionLayer.isSimilarLetter(inputChar: "i") == 2, "Test Passed")
        assert(predictionLayer.isSimilarLetter(inputChar: "k") == 3, "Test Passed")
        assert(predictionLayer.isSimilarLetter(inputChar: "u") == 4, "Test Passed")
    }
    
    ///Inputs two sets of words, one with incomplete words, the test should pass if the function return a known completed word with an index between 0 - 4 and absolute non sense words should return nil
    func testFetchPossibleWord(){
        let predictionLayer = PredictionLayer()
        
    }
    
    
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
