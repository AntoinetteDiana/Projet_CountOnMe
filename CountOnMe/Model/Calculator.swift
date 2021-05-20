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
    
    //   transforme la phrase en tableau des éléments entre espaces. le .map parcours le tableau et renvoie chaque éléments en string (exemple "1 + 1" devient ["1","+","1"])
    var elements: [String] {
        return text.split(separator: " ").map { "\($0)" }
    }
    
    //    vérifie si la phrase ne se termine pas par un opérateur
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
    }
    
    //    vérifie que la phrase à au moins trois éléments
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
    }
    
    //    cherche le "=" dans le texte et renvoie sa position. s'il ne trouve pas le "=" renvoie nil.
    var expressionHaveResult: Bool {
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
            text = ""
        }
        if text == "" {
            giveResultDelegate?.alert(message: "Ne commencez par par un opérateur !")
        } else if canAddOperator {
            text.append(" \(operatorButton) ")
        } else {
            giveResultDelegate?.alert(message: "Un operateur est déja mis !")
        }
    }
    
    
    func tappedEqualButton() {
        if !expressionIsCorrect {
            giveResultDelegate?.alert(message: "Entrez une expression correcte !")
        } else if !expressionHaveEnoughElement {
            giveResultDelegate?.alert(message: "Démarrez un nouveau calcul !")
        } else {
            var operationsToReduce = elements
            while operationsToReduce.count > 1 {
                var operandIndex = 1
                var leftIndex = 0
                var rightIndex = 2
                
                if operationsToReduce.contains("x") && !operationsToReduce.contains("/") {
                    operandIndex = operationsToReduce.firstIndex(of: "x")!
                } else if !operationsToReduce.contains("x") && operationsToReduce.contains("/") {
                    operandIndex = operationsToReduce.firstIndex(of: "/")!
                    leftIndex = operandIndex - 1
                    rightIndex = operandIndex + 1
                    
                } else if operationsToReduce.contains("x") && operationsToReduce.contains("/") {
                    if operationsToReduce.firstIndex(of: "x")! < operationsToReduce.firstIndex(of: "/")! {
                        operandIndex = operationsToReduce.firstIndex(of: "x")!
                    } else {
                        operandIndex = operationsToReduce.firstIndex(of: "/")!
                    }
                    leftIndex = operandIndex - 1
                    rightIndex = operandIndex + 1
                }
                
                let left = Double(operationsToReduce[leftIndex])!
                let operand = operationsToReduce[operandIndex]
                let right = Double(operationsToReduce[rightIndex])!
                
                let result: Double
                switch operand {
                case "+": result = left + right
                case "-": result = left - right
                case "x": result = left * right
                case "/": result = left / right
                default: return
                }
                
                operationsToReduce.remove(at:rightIndex)
                operationsToReduce.remove(at:operandIndex)
                operationsToReduce.remove(at:leftIndex)
                operationsToReduce.insert("\(result)",at:leftIndex)
            }
            text.append(" = \(operationsToReduce.first!)")
        }
    }
}
