//
//  TipBrain.swift
//  Tipsy
//
//  Created by Jeremy Rufo on 7/24/20.
//

import Foundation

struct TipBrain
{
    private var bill: Float = 0.0
    private var tip: Float = 0.0
    private var split: Int = 2
    
    init(bill: Float, tip: Float, split: Int)
    {
        updateBill(value: bill)
        updateTip(value: tip)
        updateSplit(value: split)
    }
    
    mutating func updateBill(value: Float)
    {
        self.bill = value >= 0.0 ? value : 0.0
    }
    
    mutating func updateBill(value: String?)
    {
        var newValue: Float = 0.0
        if let tempValue = Float(value!) { newValue = tempValue }
        updateBill(value: newValue)
    }
    
    mutating func updateTip(value: Float)
    {
        self.tip = value >= 0.0 ? value : 0.0
    }
    
    mutating func updateSplit(value: Double)
    {
        updateSplit(value: Int(value))
    }
    
    mutating func updateSplit(value: Int)
    {
        self.split = value >= 2 ? value : 2
    }
    
    func getBill() -> Float { return self.bill }
    func getTip() -> Float { return self.tip }
    func getSplit() -> Int { return self.split }
    
    private func getTotalBill() -> Float
    {
        let total = self.bill + getTipAmount()
        return (total * 100.0).rounded(.up) / 100.0
    }
    
    private func getTipAmount() -> Float
    {
        let total = (self.bill * self.tip)
        return (total * 100.0).rounded(.up) / 100.0
    }
    
    
    private func getTotalPerPerson() -> Float
    {
        let total = getTotalBill() / Float(self.split)
        // Make sure we round up so it doesn't go below
        // the tip percentage after splitting
        // The server will be OK with a little more
        return (total * 100.0).rounded(.up) / 100.0
    }
    
    func getTotalPerPersonText() -> String
    {
        return String(format: "$%0.2f", getTotalPerPerson())
    }
    
    func getSplitText() -> String
    {
        return """
        Bill: $\(self.bill)
        Tip (\(Int(self.tip * 100))%): $\(getTipAmount())
        Split: \(self.split) ways
        Total: $\(getTotalBill())
        """
    }
}
