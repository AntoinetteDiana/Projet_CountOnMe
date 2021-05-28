//
//  Model.swift
//  CountOnMe
//
//  Created by Antoinette Diana on 11/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol OperationCalculDelegate {
    func didResult(operation: String)
    func alert(message: String)
}

class Calculator {
    
    // MARK: - Properties
    
    var giveResultDelegate: OperationCalculDelegate?
    var text = "" {
        didSet {
            giveResultDelegate?.didResult(operation: text)
        }
    }
    
    private var elements: [String] {
        return text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
    }
    
    private var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }
    
    // MARK: - Methodes
    
    func tappedACButton() {
        text = ""
    }
    
    func tappedNumberButton(number: String) {
        if expressionHaveResult {
            text = ""
        }
        text.append(number)
    }
    
    func tappedOperatorButton(operatorButton: String) {
        if expressionHaveResult {
            guard let lastElement = elements.last else { return }
            text = lastElement
        }

        if canAddOperator {
            text.append(" \(operatorButton) ")
        } else {
            giveResultDelegate?.alert(message: "Un operateur est déja mis !")
        }
    }
    
    func tappedEqualButton() {
        guard expressionIsCorrect else {
            giveResultDelegate?.alert(message: "Entrez une expression correcte !")
            return
        }
        guard expressionHaveEnoughElement else {
            giveResultDelegate?.alert(message: "Démarrez un nouveau calcul !")
            return
        }
        var operationsToReduce = elements
        switch operationsToReduce.first {
        case "+", "-", "/", "x" : operationsToReduce.insert("0", at: 0)
        default: break
        }

        while operationsToReduce.count > 1 {
            let operandIndex = findOperatorIndex(operations: operationsToReduce)
            guard let left = Double(operationsToReduce[operandIndex - 1]) else { return }
            let operand = operationsToReduce[operandIndex]
            guard let right = Double(operationsToReduce[operandIndex + 1]) else { return }
            
            guard notDivPer0(operand: operand, right: right) else {
                giveResultDelegate?.alert(message: "Division par 0 impossible")
                return
            }
            
            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
            default: return
            }
            
            guard let formatedValue = changeFormatNumber().string(from: NSNumber(value: result)) else { return }
            operationsToReduce = reduceOperation(array: operationsToReduce, index: operandIndex, added: formatedValue)
        }
        guard let resultText = operationsToReduce.first else { return }
        text.append(" = \(resultText)")
    }
    
    // MARK: - Private methodes
    
    private func notDivPer0(operand: String, right: Double) -> Bool {
        guard operand == "/" && right == 0 else { return true }
        return false
    }
    
    private func findOperatorIndex(operations: [String]) -> Int {
        let containMult = operations.contains("x")
        let containDiv = operations.contains("/")
        let indexMult = operations.firstIndex(of: "x")
        let indexDiv = operations.firstIndex(of: "/")
        
        var operandIndex: Int {
            if containMult && !containDiv {
                return indexMult!
            }  else if !containMult && containDiv {
                return indexDiv!
            } else if containMult && containDiv {
                if indexMult! < indexDiv! {
                    return indexMult!
                } else {
                    return indexDiv!
                }
            }
            return 1
        }
        return operandIndex
    }
    
    private func changeFormatNumber() -> NumberFormatter {
        let Formatter = NumberFormatter()
        Formatter.numberStyle = .decimal
        Formatter.maximumFractionDigits = 2
        Formatter.minimumIntegerDigits = 0
        return Formatter
    }
    
    private func reduceOperation(array: [String], index: Int, added: String) -> [String] {
        var myArray = array
        myArray.remove(at:index + 1)
        myArray.remove(at:index)
        myArray.remove(at:index - 1)
        myArray.insert("\(added)",at:index - 1)
        return myArray
    }
    
}
