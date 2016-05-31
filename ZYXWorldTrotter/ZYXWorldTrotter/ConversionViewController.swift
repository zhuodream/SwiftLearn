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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)

        let r = CGFloat.init(arc4random() % 255) / 255.0
        let g = CGFloat.init(arc4random() % 255) / 255.0
        let b = CGFloat.init(arc4random() % 255) / 255.0
        
        self.view.backgroundColor = UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField)
    {
        if let text = textField.text, number = numberFormatter.numberFromString(text)
        {
            fahrenheitValue = number.doubleValue
        }
        else
        {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject)
    {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel()
    {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        let currentLocale = NSLocale.currentLocale()
        let decimalSeparator = currentLocale.objectForKey(NSLocaleDecimalSeparator) as! String
        
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(decimalSeparator)
        let replacementTextHasDecimalSeparator = string.rangeOfString(decimalSeparator)
        
        if string.characters.count > 1 {
            let str = string.substringWithRange(Range<String.Index>((replacementTextHasDecimalSeparator?.startIndex.advancedBy(1))!..<string.endIndex))
            
            let againDecialRange = str.rangeOfString(decimalSeparator)
            
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
