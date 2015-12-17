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

    @IBOutlet weak var Item1: UITextField!
    
    @IBOutlet weak var Quantity1: UITextField!
    
    @IBOutlet weak var result1Label: UILabel!
    
    @IBOutlet weak var Item2: UITextField!
    
    @IBOutlet weak var Quantity2: UITextField!
    
    @IBOutlet weak var result2Label: UILabel!
    
    @IBOutlet weak var calcButton: UIButton!
    
    @IBAction func oneCalc(sender: UIButton) {
        newCalc()
        calcButton.backgroundColor = UIColor.grayColor()
    }
    
    // TODO: Set some other customizations
    
    func textFieldDidBeginEditing(textField: UITextField) {
        calcButton.backgroundColor = UIColor.greenColor()
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
        
    let result1 = calculator.divide(priceArray[0], val2: quantityArray[0])
        let decimalValue = Double(round(1000*result1)/1000)
        result1Label.text = (String(format: " $%.2f / unit", decimalValue))

    let eval1 = Double(Item2.text!) ?? 0
            priceArray.insert(eval1, atIndex: 1)
        let eval2 = Double(Quantity2.text!) ?? 0
            quantityArray.insert(eval2, atIndex: 1)
        let result2 = calculator.divide(priceArray[1], val2: quantityArray[1])
        let decimalValue2 = Double(round(1000*result2)/1000)
        
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
            result1Label.backgroundColor = UIColor.greenColor()
            result2Label.backgroundColor = UIColor.redColor()
            calcButton.setTitle(String(format: "⬅︎ Save: $%.2f / unit", differenceOf), forState: UIControlState.Normal)
        } else if rightPrice < leftPrice {
            result2Label.backgroundColor = UIColor.greenColor()
            result1Label.backgroundColor = UIColor.redColor()
            calcButton.setTitle(String(format: "Save: $%.2f / unit ➡︎", differenceOf), forState: UIControlState.Normal)
        } else if leftPrice == rightPrice {
            calcButton.setTitle("Equal", forState: UIControlState.Normal)
            result1Label.backgroundColor = UIColor.whiteColor()
            result2Label.backgroundColor = UIColor.whiteColor()
        }
    }
    

//    result1Label.backgroundColor = UIColor.whiteColor()
    
    func clear() {
        Item1.text = ""
        Item2.text = ""
        Quantity1.text = ""
        Quantity2.text = ""
        result1Label.text = ""
        result2Label.text = ""
        result1Label.backgroundColor = UIColor.clearColor()
        result2Label.backgroundColor = UIColor.clearColor()
        calcButton.setTitle("Calculate", forState: UIControlState.Normal)
        Item1.becomeFirstResponder()        
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

