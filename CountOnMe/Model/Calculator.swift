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

class GiveResult {
    
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
                default: return
                }
                
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(result)", at: 0)
            }
            text.append(" = \(operationsToReduce.first!)")
        }
    }


}
