//
//  ViewController.swift
//  Tipsy
//
//  Created by Jeremy Rufo
//  Copyright © 2020 Jeremy Rufo
//

import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var stepperControl: UIStepper!
    
    var buttonGroup: [UIButton]?
    
    var tipBrain = TipBrain(bill: 10.0, tip: 0.1, split: 2)
    
    override func viewDidLoad()
    {
        // Set up button group for easy deselecting
        buttonGroup = [zeroPctButton, tenPctButton, twentyPctButton]
        
        // Update controls and text
        updateBillUI(value: tipBrain.getBill())
        updateTipUI(value: tipBrain.getTip())
        updateSplitUI(value: tipBrain.getSplit())
        
        billTextField.delegate = self
        billTextField.tag = 0 //Increment accordingly
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
       // Try to find next responder
       if let nextField =
        textField.superview?.viewWithTag(textField.tag + 1) as? UITextField
       {
          nextField.becomeFirstResponder()
       }
       else
       {
          // Not found, so remove keyboard.
          textField.resignFirstResponder()
       }
       // Do not add a line break
       return false
    }
    
    @IBAction func billEntered(_ sender: UITextField)
    {
        billTextField.endEditing(true)
        tipBrain.updateBill(value: sender.text)
    }
    
    func updateBillUI(value: Float)
    {
        switch value
        {
            case 0.0:
                billTextField.text = String(format: "$%0.2f", value)
                break
            default:
                billTextField.text = ""
        }
    }

    @IBAction func tipChanged(_ sender: UIButton)
    {
        billTextField.endEditing(true)
        tipBrain.updateTip(value: getTipFromButton(button: sender))
        updateTipUI(value: tipBrain.getTip())
    }
    
    func updateTipUI(value: Float)
    {
        // Deselect all the buttons
        buttonGroup?.forEach { $0.isSelected = false }
        if value == 0.0 { zeroPctButton.isSelected = true }
        if value == 0.10 { tenPctButton.isSelected = true }
        if value == 0.20 { twentyPctButton.isSelected = true }
    }
    
    private func getTipFromButton(button: UIButton) -> Float
    {
        if button == tenPctButton { return 0.10 }
        else if button == twentyPctButton { return 0.20 }
        return 0.0
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper)
    {
        billTextField.endEditing(true)
        tipBrain.updateSplit(value: sender.value)
        updateSplitUI(value: tipBrain.getSplit())
    }
    
    func updateSplitUI(value: Int)
    {
        splitNumberLabel.text = "\(value)"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton)
    {
        billTextField.endEditing(true)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    func getTipObject() -> TipObject
    {
        return TipObject(totalText: tipBrain.getTotalPerPersonText(), splitText: tipBrain.getSplitText())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToResult"
        {
            let destinationVC = segue.destination as? ResultsViewController
            destinationVC?.tipObject = getTipObject()
        }
    }
}
