//
//  Model.swift
//  CountOnMe
//
//  Created by Antoinette Diana on 11/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol OperationCalculDelegate {
    func didResult(operation: [String])
}

class GiveResult {
    
    var giveResultDelegate: OperationCalculDelegate?
    var operationsToReduceProperties = [String]()
    
    func getResults(operationsToReduce: [String]) {
        var operationsToReduce = operationsToReduce
        var operandIndex = 0
        var left = 0
        var operand = ""
        var right = 0
        
        while operationsToReduce.count > 1 {
            if operationsToReduce.firstIndex(of: "x") != nil || operationsToReduce.firstIndex(of: "/") != nil {
                if operationsToReduce.firstIndex(of: "x") != nil {
                    operandIndex = operationsToReduce.firstIndex(of: "x")!
                } else if operationsToReduce.firstIndex(of: "/") != nil {
                    operandIndex = operationsToReduce.firstIndex(of: "/")!
                }
                left = Int(operationsToReduce[operandIndex - 1])!
                operand = operationsToReduce[operandIndex]
                right = Int(operationsToReduce[operandIndex + 1])!
            } else {
                left = Int(operationsToReduce[0])!
                operand = operationsToReduce[1]
                right = Int(operationsToReduce[2])!
            }
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
            self.operationsToReduceProperties = operationsToReduce
        }
        giveResultDelegate?.didResult(operation: operationsToReduce)
    }
    
    
    
}



