//
//  ViewController.swift
//  Calculator
//
//  Created by SK on 3/12/17.
//  Copyright © 2017 SK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // instance variables are properties in swift
    // optionals are automatically set to nil
    // nil means not set
    @IBOutlet weak var display: UILabel!
    
    // var must be initialized
    var userIsInTheMiddleOfTyping = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        brain.addUnaryOperation(named: "✅") { [weak weakSelf = self] in
            weakSelf?.display.textColor = UIColor.green
            return sqrt($0)
        }
    }
    
    // _ sender means no external
    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping
        {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else
        {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
        //print("\(digit) was touched")
    }
    
    var displayValue: Double
    {
        get
        {
            return Double(display.text!)!
        }

        set
        {
            display.text = String(newValue)
        }
    }
    
    private var brain: CalculatorBrain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping
        {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle
        {
            brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result
        {
            displayValue = result 
        }
        
    }
}

