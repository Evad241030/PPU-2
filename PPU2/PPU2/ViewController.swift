//
//  ViewController.swift
//  PPU2
//
//  Created by DAVID GONZALEZ on 10/30/15.
//  Copyright © 2015 David Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // Using Calculator class to do my division
    let calculator = Calculator()

    // Setting Custom colors
    let myGreen = UIColor(red: 88/255, green: 185/255, blue: 142/255, alpha: 1)
    let myRed = UIColor(red: 228/55, green: 56/255, blue: 68/255, alpha: 1)
    

    @IBOutlet weak var Item1: UITextField!
    
    @IBOutlet weak var Quantity1: UITextField!
    
    @IBOutlet weak var result1Label: UILabel!
    
    @IBOutlet weak var Item2: UITextField!
    
    @IBOutlet weak var Quantity2: UITextField!
    
    @IBOutlet weak var result2Label: UILabel!
    
    @IBOutlet weak var calcButton: UIButton!
    
    @IBOutlet weak var clearBtn: UIButton!
    
    
// Main Calculation button - One button for simplicity
    @IBAction func oneCalc(sender: UIButton) {
        newCalc()
    // Changing color to indicate calculation is complete.
        calcButton.backgroundColor = UIColor.lightGrayColor()


    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Clears out results when changing values - let's user know to hit calculate again
        miniClear()
        calcButton.backgroundColor = myGreen
        calcButton.setTitle("Calculate", forState: UIControlState.Normal)
        
    }

    var decimalValue = Double()
    var decimalValue2 = Double()
   
    
//CalculateHit - This runs in my oneCalc Button Action
    func newCalc() {
    var priceArray : [Double] = []
    var quantityArray : [Double] = []
    let val1 = Double(Item1.text!) ?? 0.0
        priceArray.insert(val1, atIndex: 0)
    let val2 = Double(Quantity1.text!) ?? 0.0
            quantityArray.insert(val2, atIndex: 0)
  
// FIXME: How do I format 2 decimal places for greatest accuracy?
        
    let result1 = calculator.divide(priceArray[0], val2: quantityArray[0])
        let decimalValue = result1
        result1Label.text = (String(format: " $%.2f / unit", decimalValue))

    let eval1 = Double(Item2.text!) ?? 0
            priceArray.insert(eval1, atIndex: 1)
        let eval2 = Double(Quantity2.text!) ?? 0
            quantityArray.insert(eval2, atIndex: 1)
        let result2 = calculator.divide(priceArray[1], val2: quantityArray[1])
        let decimalValue2 = result2
//        let decimalValue2 = Double(round(1000*result2)/1000)
        
        result2Label.text = (String(format: " $%.2f / unit", decimalValue2))
        
        let leftPrice = decimalValue
        let rightPrice = decimalValue2
        var differenceOf = Double()

        if leftPrice < rightPrice {
            differenceOf = rightPrice - leftPrice
        } else if rightPrice < leftPrice {
            differenceOf = leftPrice - rightPrice
        }
    

        
        if leftPrice < rightPrice {
            result1Label.backgroundColor = myGreen
            result2Label.backgroundColor = myRed
            calcButton.setTitle(String(format: "Save: $%.2f / unit", differenceOf), forState: UIControlState.Normal)
        } else if rightPrice < leftPrice {
            result2Label.backgroundColor = myGreen
            result1Label.backgroundColor = myRed
            calcButton.setTitle(String(format: "Save: $%.2f / unit", differenceOf), forState: UIControlState.Normal)
        } else if leftPrice == rightPrice {
            calcButton.setTitle("Equal", forState: UIControlState.Normal)
            result1Label.backgroundColor = UIColor.whiteColor()
            result2Label.backgroundColor = UIColor.whiteColor()
        }
// FIXME: Not able to get the result1 label to fly in from left side of screen
        result1Label.center.x = self.view.frame.width + 200
        result2Label.center.x = self.view.frame.width + 200

        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: { () -> Void in
// FIXME: I had to guess this position - not sure how to get an exact value.
            self.result1Label.center.x = self.view.frame.width - 248
            self.result2Label.center.x = self.view.frame.width - 248
            }, completion: nil)
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.result1Label.alpha = 1
            self.result2Label.alpha = 1
        }
        dismissKeyboard()

    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
// reset results when some re-edit is taking place.
    func miniClear() {
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.result1Label.alpha = 0
            self.result2Label.alpha = 0
        }

    }
    

//    result1Label.backgroundColor = UIColor.whiteColor()
    
    func clear() {
        Item1.text = ""
        Item2.text = ""
        Quantity1.text = ""
        Quantity2.text = ""
        calcButton.setTitle("Calculate", forState: UIControlState.Normal)
        Item1.becomeFirstResponder()
        UIView.animateWithDuration(0.3) { () -> Void in
            self.result1Label.alpha = 0
            self.result2Label.alpha = 0
        }
        
        
        UIView.animateWithDuration(10, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: { () -> Void in
            self.result1Label.center.x = self.view.frame.width - 200
            self.result2Label.center.x = self.view.frame.width - 200
            }, completion: nil)
    }
    
    @IBAction func ClearAllHit(sender: UIButton) {
        clear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Item1.delegate = self
        Quantity1.delegate = self
        Item2.delegate = self
        Quantity2.delegate = self
        Item1.center.x = self.view.frame.width - 200

        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        UIView.animateWithDuration(0.5, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: { () -> Void in
            self.Item1.center.x = self.view.frame.width + 200
            }, completion: nil)
        
        Item1.becomeFirstResponder()

        // Do any additional setup after loading the view, typically from a nib.
    }


    

}

