//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
// MARK: - @IB Outlet
    
//    lien avec le storyboard Controller -> View
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
// MARK: - @IB Action
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        addOperator(operatorButton: sender.title(for: .normal)!)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        addOperator(operatorButton: "+")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if expressionHaveResult {
            textView.text = ""
        }
        if textView.text == "" {
            let alertVC = UIAlertController(title: "Zéro!", message: "Ne commencez par par un opérateur !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        } else if canAddOperator {
            textView.text.append(" - ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
   
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if expressionHaveResult {
            textView.text = ""
        }
        if textView.text == "" {
            let alertVC = UIAlertController(title: "Zéro!", message: "Ne commencez par par un opérateur !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        } else if canAddOperator {
            textView.text.append(" / ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if expressionHaveResult {
            textView.text = ""
        }
        if textView.text == "" {
            let alertVC = UIAlertController(title: "Zéro!", message: "Ne commencez par par un opérateur !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        } else if canAddOperator {
            textView.text.append(" x ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        textView.text = ""
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        operation.getResults(operationsToReduce: elements)
    }
    
// MARK: - Methodes
    
    private func addOperator(operatorButton: String) {
        if expressionHaveResult {
            textView.text = ""
        }
        if textView.text == "" {
            let alertVC = UIAlertController(title: "Zéro!", message: "Ne commencez par par un opérateur !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        } else if canAddOperator {
            textView.text.append(" \(operatorButton) ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
// MARK: - Properties

//   transforme la phrase en tableau des éléments entre espaces. le .map parcours le tableau et renvoie chaque éléments en string (exemple "1 + 1" devient ["1","+","1"])
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
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
        return textView.text.firstIndex(of: "=") != nil
    }
    
    var operation = GiveResult()
    
// MARK: - View Life Cycles
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        operation.giveResultDelegate = self
    }

}

// MARK: - Extension Protocole
extension ViewController : OperationCalculDelegate {
    func didResult(operation: [String]) {
        textView.text.append(" = \(operation.first!)")
    }
    
}
