//
//  CalculatorBrain.swift
//  CalcEx
//
//  Created by Padmnabh Vyas on 10/20/16.
//  Copyright © 2016 Developer iOS. All rights reserved.
//

import Foundation



class CalculatorBrain
{
    private var accumulator = 0.0
    
    func setOprand(operand: Double) {
        
        accumulator = operand
    }
    
    private var operation: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "±": Operation.UnaryOperation({ -$0}),
        "×": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "-": Operation.BinaryOperation({ $0 - $1 }),
        "=": Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)-> Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    
    private var pending: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    
    func perforOperation(symbol: String){
        
        if  let operation = operation[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperation(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        
        }
    }
    
    func executePendingBinaryOperation()
    {
        if pending != nil
        {
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending = nil
            
        }
    }
    
    var result: Double{
        get{
         return accumulator
        }
    }
}
