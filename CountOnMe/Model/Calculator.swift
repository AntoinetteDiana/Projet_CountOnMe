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
        if canAddOperator {
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
            switch operationsToReduce.first {
            case "+", "-", "x", "/":
                operationsToReduce.insert("0", at: 0)
            default:
                break
            }
            
            while operationsToReduce.count > 1 {

                let containMult = operationsToReduce.contains("x")
                let containDiv = operationsToReduce.contains("/")
                let indexMult = operationsToReduce.firstIndex(of: "x")
                let indexDiv = operationsToReduce.firstIndex(of: "/")
                
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
                    } else {
                        return 1
                    }
                }
                
                let left = Double(operationsToReduce[operandIndex - 1])!
                let operand = operationsToReduce[operandIndex]
                let right = Double(operationsToReduce[operandIndex + 1])!
                
                let result: Double
                switch operand {
                case "+": result = left + right
                case "-": result = left - right
                case "x": result = left * right
                case "/":
                    if right != 0 {
                        result = left / right
                    } else {
                        giveResultDelegate?.alert(message: "Division par 0 impossible")
                        return
                    }
                default: return
                }
                
                
                let resultIntString = "\(Int(result)).00"
                let resultString = String(format: "%.2f", result)
                
                var resultFinal = resultString
                
                if resultIntString == resultString {
                    resultFinal = "\(Int(result))"
                }
                
                operationsToReduce.remove(at:operandIndex + 1)
                operationsToReduce.remove(at:operandIndex)
                operationsToReduce.remove(at:operandIndex - 1)
                operationsToReduce.insert("\(resultFinal)",at:operandIndex - 1)
            }
            text.append(" = \(operationsToReduce.first!)")
        }
    }
}
