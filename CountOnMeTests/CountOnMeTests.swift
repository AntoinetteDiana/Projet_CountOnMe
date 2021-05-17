//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Antoinette Diana on 11/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {

    
    func testGivenNumber1Plus1_WhenaskingForResult_ThenResultIs2() {
        let operations = GiveResult()
        let calcul = ["1", "+", "1"]
        
        operations.getResults(operationsToReduce: calcul)
    
        XCTAssert(operations.operationsToReduceProperties == ["2"])
    }
    
    func testGivenNumber1minus1_WhenaskingForResult_ThenResultIs0() {
        let operations = GiveResult()
        let calcul = ["1", "-", "1"]
        
        operations.getResults(operationsToReduce: calcul)
    
        XCTAssert(operations.operationsToReduceProperties == ["0"])
    }

//    func testGivenNumber1X1_WhenaskingForResult_ThenResultIsFatalError() {
//        let operations = GiveResult()
//        let calcul = ["1", "X", "1"]
//
//        operations.getResults(operationsToReduce: calcul)
//    XCTExpectFailure()
//    XCTAssertThrowsError("Unknown operator !")
//    }
    
}
