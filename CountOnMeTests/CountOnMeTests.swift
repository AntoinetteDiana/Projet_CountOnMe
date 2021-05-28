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
    
    
    func testGivenNumber1Plus1_WhenTappingEqualButton_ThenResultIs2() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "1")
        calculator.tappedOperatorButton(operatorButton: "+")
        calculator.tappedNumberButton(number: "1")
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(calculator.text, "1 + 1 = 2")
    }
    
    func testGivenNumber1minus1_WhenTappingEqualButton_ThenResultIs0() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "1")
        calculator.tappedOperatorButton(operatorButton: "-")
        calculator.tappedNumberButton(number: "1")
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(calculator.text, "1 - 1 = 0")
    }
    
    func testGivenNumber2x1_WhenTappingEqualButton_ThenResultIs2() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "2")
        calculator.tappedOperatorButton(operatorButton: "x")
        calculator.tappedNumberButton(number: "1")
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(calculator.text, "2 x 1 = 2")
    }
    
    func testGivenNumber4Div2_WhenTappingEqualButton_ThenResultIs2() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "4")
        calculator.tappedOperatorButton(operatorButton: "/")
        calculator.tappedNumberButton(number: "2")
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(calculator.text, "4 / 2 = 2")
    }
    
    func testGivenNumber4Div2x3_WhenTappingEqualButton_ThenResultIs6() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "4")
        calculator.tappedOperatorButton(operatorButton: "/")
        calculator.tappedNumberButton(number: "2")
        calculator.tappedOperatorButton(operatorButton: "x")
        calculator.tappedNumberButton(number: "3")
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(calculator.text, "4 / 2 x 3 = 6")
    }
    
    func testGivenNumber2x2Plus1Plus4Div2_WhenTappingEqualButton_ThenResultIs7() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "2")
        calculator.tappedOperatorButton(operatorButton: "x")
        calculator.tappedNumberButton(number: "2")
        calculator.tappedOperatorButton(operatorButton: "+")
        calculator.tappedNumberButton(number: "1")
        calculator.tappedOperatorButton(operatorButton: "+")
        calculator.tappedNumberButton(number: "4")
        calculator.tappedOperatorButton(operatorButton: "/")
        calculator.tappedNumberButton(number: "2")
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(calculator.text, "2 x 2 + 1 + 4 / 2 = 7")
    }
    
    func testGivenNumber1OtherSign1_WhenTappingEqualButton_ThenResultIsNotPossible() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "1")
        calculator.tappedOperatorButton(operatorButton: "&")
        calculator.tappedNumberButton(number: "1")
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(calculator.text, "1 & 1")
    }
   
    func testGivenNumber1Plus_WhenTappingEqualButton_ThenIsExpressionNotCorrect() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "1")
        calculator.tappedOperatorButton(operatorButton: "+")
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(calculator.text, "1 + ")
    }
    
    func testGivenNumber1_WhenTappingEqualButton_ThenIsExpressionNotCorrect() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "1")
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(calculator.text, "1")
    }
    
    func testGivenNumber1Plus1Equal2_WhenAddingNumber1_ThenTextIs1() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "1")
        calculator.tappedOperatorButton(operatorButton: "+")
        calculator.tappedNumberButton(number: "1")
        calculator.tappedEqualButton()
        
        calculator.tappedNumberButton(number: "1")

        
        XCTAssertEqual(calculator.text, "1")
    }
    
    func testGivenNumber1Plus1_WhenTappingACButton_ThenTextIsNil() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "1")
        calculator.tappedOperatorButton(operatorButton: "+")
        calculator.tappedNumberButton(number: "1")
        
        calculator.tappedACButton()

        
        XCTAssertEqual(calculator.text, "")
    }
    
    func testGivenNumber1Plus1Equal2_WhenAddingOperatorButton_ThenIsResultIsPlus() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "1")
        calculator.tappedOperatorButton(operatorButton: "+")
        calculator.tappedNumberButton(number: "1")
        calculator.tappedEqualButton()
        
        calculator.tappedOperatorButton(operatorButton: "+")

        
        XCTAssertEqual(calculator.text, "2 + ")
    }
    
    func testGivenNumber1Plus_WhenAddingOperatorButton_ThenTextIs1PLus() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "1")
        calculator.tappedOperatorButton(operatorButton: "+")
        
        calculator.tappedOperatorButton(operatorButton: "+")

        
        XCTAssertEqual(calculator.text, "1 + ")
    }
    
    func testGivenNumberMinus1Plus1_WhenTappingEqualButton_ThenTextIs1PLus() {
        let calculator = Calculator()
        calculator.tappedOperatorButton(operatorButton: "-")
        calculator.tappedNumberButton(number: "1")
        calculator.tappedOperatorButton(operatorButton: "+")
        calculator.tappedNumberButton(number: "1")
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(calculator.text, " - 1 + 1 = 0")
    }
    
    func testGivenNumber1Div0_WhenTappingEqualButton_ThenTextIs1Div() {
        let calculator = Calculator()
        calculator.tappedNumberButton(number: "1")
        calculator.tappedOperatorButton(operatorButton: "/")
        calculator.tappedNumberButton(number: "0")
        
        calculator.tappedEqualButton()
        
        XCTAssertEqual(calculator.text, "1 / 0")
    }
}
