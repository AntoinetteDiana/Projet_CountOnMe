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
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
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



