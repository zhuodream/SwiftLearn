//
//  ConversionViewController.swift
//  ZYXWorldTrotter
//
//  Created by 卓酉鑫 on 16/5/27.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue{
            return (value - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField)
    {
        if let text = textField.text, value = Double(text) {
            fahrenheitValue = value
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject)
    {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(".")
        let replacementTextHasDecimalSeparator = string.rangeOfString(".")
        
        if string.characters.count > 1 {
            let str = string.substringWithRange(Range<String.Index>((replacementTextHasDecimalSeparator?.startIndex.advancedBy(1))!..<string.endIndex))
            
            let againDecialRange = str.rangeOfString(".")
            
            if againDecialRange != nil {
                return false
            }

        }
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        }
        
        let replacementText: NSCharacterSet = NSCharacterSet(charactersInString: string)
        let allowedCharacter = NSCharacterSet.init(charactersInString: "0123456789" + numberFormatter.decimalSeparator)
        if !allowedCharacter.isSupersetOfSet(replacementText)
        {
            return false
        }
        
        return true
    }
}
