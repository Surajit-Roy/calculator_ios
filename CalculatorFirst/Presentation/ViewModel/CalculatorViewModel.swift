//
//  CalculatorViewModel.swift
//  CalculatorFirst
//
//  Created by Surajit on 10/02/25.
//

import Foundation


class CalculatorViewModel {
    
    private let performCalculationUseCase: PerformCalculationUseCaseProtocol
    
    var onExpressionUpdate: ((String) -> Void)?
    var onResultUpdate: ((String) -> Void)?
    
    private var expression: String = "" {
        didSet {
            onExpressionUpdate?(expression)
        }
    }
    
    init(useCase: PerformCalculationUseCaseProtocol) {
        self.performCalculationUseCase = useCase
    }
    
    func handleButtonTap(_ action: ButtonAction) {
        switch action {
        case .ac:
            clearExpression()
        case .back:
            removeLastCharacter()
        case .equal:
            calculateResult()
        default:
            appendSymbol(action)
        }
    }

    private func clearExpression() {
        expression = ""
        onResultUpdate?("")
    }

    private func removeLastCharacter() {
        guard !expression.isEmpty else { return }
        expression.removeLast()
    }

    private func calculateResult() {
        guard !expression.isEmpty else{
            onResultUpdate?("0")
            return
        }
        
        // If the last entered value is an operator or only contains '%' or '.', return "0"
        if isInvalidEnding(expression) {
            onResultUpdate?("")
            return
        }
        
        if let result: Int = performCalculationUseCase.calculate(expression: expression) {
            onResultUpdate?("\(result)")
        } else if let result: Double = performCalculationUseCase.calculate(expression: expression) {
            onResultUpdate?("\(result)")
        } else {
            onResultUpdate?("Error")
        }
    }

    // Check if the last character is an invalid operator or just '%' or '.'
    private func isInvalidEnding(_ expression: String) -> Bool {
        let invalidEndings = [".", "+", "-", "*", "/"]
        if invalidEndings.contains(String(expression.last!)) { return true }
        
        if expression.last == "%" {
            // Allow cases like "40*10%" but not "%" alone
            return expression.count == 1 || "+-*/".contains(expression[expression.index(before: expression.endIndex)])
        }
        
        return false
    }

    private func appendSymbol(_ action: ButtonAction) {
        expression += mapButtonToSymbol(action)
    }

    private func mapButtonToSymbol(_ action: ButtonAction) -> String {
        switch action {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "*"
        case .divide: return "/"
        case .percentage: return "%"
        case .dot: return "."
        case .zerozero: return "00"
        default: return "\(action.rawValue)"
        }
    }
}

