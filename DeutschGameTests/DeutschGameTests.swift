//
//  DeutschGameTests.swift
//  DeutschGameTests
//
//  Created by Nacho on 2/6/16.
//  Copyright © 2016 LandhGames™. All rights reserved.
//

import XCTest
@testable import DeutschGame

class DeutschGameTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWordInit(){
        let w = Word(english: "hello", german: "hallo", spanish: "hola")
        XCTAssert(w.englishVersion == "hello" && w.germanVersion == "hallo" && w.spanishVersion == "hola")
    }
    
    func testCorrectGuesses(){
        let w = Word(english: "hello", german: "hallo", spanish: "hola")
        
        for _ in 0..<30{
            w.addCorrectGuess()
        }
        
        XCTAssert(w.score == 30)
    }
    
    func testCorrectUnguesses(){
        let w = Word(english: "hello", german: "hallo", spanish: "hola")
        
        for _ in 0..<30{
            w.addWrongGuess()
        }
        print(w.score)
        XCTAssert(w.score == -30)
    }
    
}
