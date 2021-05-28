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
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // MARK: - @IB Action
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculOperation.tappedNumberButton(number: sender.title(for: .normal)!)
    }
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        calculOperation.tappedOperatorButton(operatorButton: sender.title(for: .normal)!)
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        calculOperation.tappedACButton()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculOperation.tappedEqualButton()
    }
    
    // MARK: - Properties
    
    var calculOperation = Calculator()
    
    // MARK: - View Life Cycles
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calculOperation.giveResultDelegate = self
    }
    
}

// MARK: - Extension Protocole

extension ViewController : OperationCalculDelegate {
    func didResult(operation: String) {
        textView.text = operation
    }
    
    func alert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
