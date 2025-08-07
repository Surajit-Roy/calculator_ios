//
//  CalculatorViewController.swift
//  CalculatorFirst
//
//  Created by Surajit on 10/02/25.
//

import Foundation
import UIKit

class CalculatorViewController: UIViewController {
    
    var viewModel: CalculatorViewModel!

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var answerField: UILabel!
    @IBOutlet weak var vStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DICalculatorContainer.shared.makeCalculatorViewModel()
        setupBindings()
        setupButtons()
        
        inputField.inputView = UIView() // empty view disables keyboard
        inputField.becomeFirstResponder()   // show cursor immediately
        inputField.tintColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupButtons() // Ensures view is fully loaded
    }

    private func setupBindings() {
        viewModel.onExpressionUpdate = { [weak self] expression in
            self?.inputField.text = expression
        }
        
        viewModel.onResultUpdate = { [weak self] result in
            self?.answerField.text = result
        }
    }

    private func setupButtons() {
        guard let stackSubviews = vStackView?.subviews else {
            print("vStackView is nil")
            return
        }
        
        for vStack in stackSubviews {
            for hStack in vStack.subviews {
                if let button = hStack as? UIButton {
                    button.layer.cornerRadius = 38
                    button.layer.masksToBounds = true
                    button.tintColor = .black
                    button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                }
            }
        }
    }


    @objc private func buttonTapped(_ sender: UIButton) {
        if let action = ButtonAction(rawValue: sender.tag) {
            viewModel.handleButtonTap(action)
        }
    }
}

class HideKeyboard: UITextField {
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputView: UIView? {
        get {UIView()}
        set {}
    }
}
