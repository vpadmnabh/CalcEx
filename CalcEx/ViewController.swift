//
//  ViewController.swift
//  CalcEx
//
//  Created by Developer iOS on 13/10/16.
//  Copyright © 2016 Developer iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInMiddleOFTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        if(userIsInMiddleOFTyping)
        {
        let textCurrentlyDisplay = display.text!
            display.text! = textCurrentlyDisplay + digit
        }else{
        display.text! = digit
        }
        userIsInMiddleOFTyping = true
        
        
    }
    
    private var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
        display.text = String(newValue)
        }
    
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        
        
        if userIsInMiddleOFTyping{
        brain.setOprand(operand: displayValue)
            userIsInMiddleOFTyping = false
        }
        
        if let methamaticalSymol = sender.currentTitle{
            brain.perforOperation(symbol: methamaticalSymol)
        }
        
        displayValue = brain.result 
    }
    

}

