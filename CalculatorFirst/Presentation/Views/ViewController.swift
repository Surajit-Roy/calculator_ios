//
//  ViewController.swift
//  CalculatorFirst
//
//  Created by Surajit on 29/01/25.
//

import UIKit

class CalculatorController: UIViewController {

    var values = ""
    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var answerField: UILabel!
    @IBOutlet weak var vStackView: UIStackView!
    
    @IBAction func calculatorActions(_ sender: UIButton) {
        if let action = ButtonAction(rawValue: sender.tag) {
            calculate(buttonAction: action)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for vStack in vStackView.subviews {
            for hStack in vStack.subviews {
                if let button = hStack as? UIButton {
                    button.layer.cornerRadius = 38
                    button.layer.masksToBounds = true
                    button.tintColor = .black
                }
            }
        }
    }

    func calculate(buttonAction: ButtonAction)  {
        switch buttonAction {
            
        case .ac:
            clearAll()
        case .percentage:
            percentagevalue()
        case .back:
            backSpace()
        case .divide:
            divideValue()
        case .multiply:
            multiplyValue()
        case .subtract:
            subtractValue()
        case .add:
            addValue()
        case .equal:
            equalValue()
        case .seven:
            values = values+"7"
        case .eight:
            values = values+"8"
        case .nine:
            values = values+"9"
        case .four:
            values = values+"4"
        case .five:
            values = values+"5"
        case .six:
            values = values+"6"
        case .one:
            values = values+"1"
        case .two:
            values = values+"2"
        case .three:
            values = values+"3"
        case .zerozero:
            values = values+"00"
        case .zero:
            values = values+"0"
        case .dot:
            values = values+"."
        }
        inputField.text = values

    }
    
    func clearAll() {
        values = ""
        answerField.text = values
        inputField.text = values
    }
    
    func percentagevalue() {
    }
    
    func backSpace() {
        if values.count > 0 {
            if(values.count == 1){
                values = ""
            } else{
                values.removeLast()
            }
        }
    }
    
    func divideValue() {
    }
    
    func multiplyValue() {
    }
    
    func subtractValue() {
    }
    
    func addValue() {
        values = values + "+"
    }
    
    func equalValue() {
    }
}

