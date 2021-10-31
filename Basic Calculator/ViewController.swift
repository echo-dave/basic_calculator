//
//  ViewController.swift
//  Basic Calculator
//
//  Created by Dave M on 10/30/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calcNumDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
               calcNumDisplay.isUserInteractionEnabled = true
        swipe.direction = .left
               calcNumDisplay.addGestureRecognizer(swipe)
        
    }

    let numArray = ["1","2","3","4","5","6","7","8","9","0","."]
    var numString: String = ""
    var opperatingNum = 0.0
    var calculatedNum = 0.0
    var prevOpperator = ""

    @IBAction func allClear(_ sender: UIButton) {
        calcNumDisplay.text = "0"
        numString = ""
        calculatedNum = 0.0
        opperatingNum = 0.0
    }
    
    @IBAction func convertPercentage(_ sender: UIButton) {
        if numString != "" && numString != "0" {
            numString = String(Double(numString)! / 100)
            calcNumDisplay.text = numString
        }
    }

    @IBAction func tapFunction(sender: UISwipeGestureRecognizer) {
            print("tap working")
        if numString.count > 1 {
            numString.removeLast()
            calcNumDisplay.text = numString
        }
    }
    
    @IBAction func changePosNeg(_ sender: UIButton) {
//        print(numString.first)
        print(numString[numString.index(numString.startIndex, offsetBy: 0)])
        if numString[numString.index(numString.startIndex, offsetBy: 0)] == "-" {
            numString.remove(at: numString.startIndex)
            print("numString after -/+ is: \(numString)")
        } else {
            numString.insert("-", at: numString.startIndex)
        }
        calcNumDisplay.text = numString
        print("updated: \(numString)")
      
    }
    
    @IBAction func setOpperator(_ sender: UIButton) {
//        print(sender.titleLabel?.text)
        guard let opperator = sender.titleLabel?.text else {return}
        calculate(opperator)
    }
    
    func calculate(_ opperator: String) {
        if numString != "" {
        opperatingNum = Double(numString)!
        }
        numString = ""
        if calculatedNum != 0.0 {
            switch prevOpperator {
            case "÷":
                 calculatedNum /= opperatingNum
            case "x":
                 calculatedNum *= opperatingNum
            case "+":
                calculatedNum += opperatingNum
            case "-":
                calculatedNum -= opperatingNum
            case "=":
                print("opperator for \"=\" \(prevOpperator)")
                calculate(prevOpperator)
            default:
                break
            }
        } else {
            calculatedNum = opperatingNum
        }
        
        calcNumDisplay.text = String(calculatedNum)
        if opperator != "=" { prevOpperator = opperator }
        print("clalc: \(calculatedNum)")
        print("opperating Num: \(opperatingNum)")
    }
    
    @IBAction func getNumbers(_ sender: UIButton) {
        guard let buttonInput = sender.titleLabel?.text else {return}
        concatNum(buttonInput)
       
        func concatNum(_ num: String) {
            numString += String(num)
            print(numString)
            calcNumDisplay.text = numString
        }
    }
    
   

}


