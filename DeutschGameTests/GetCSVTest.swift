//
//  GetCSVTest.swift
//  DeutschGame
//
//  Created by Nacho on 2/26/16.
//  Copyright © 2016 LandhGames™. All rights reserved.
//

import XCTest

class GetCSVTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParser(){
        let csv = GetCSV()
        let result = csv.parseLine("hello,hallo")
        XCTAssert(result.0 == "hello" && result.1 == "hallo")
    }
    
}
