//
//  CalculatorRepository.swift
//  CalculatorFirst
//
//  Created by Surajit on 10/02/25.
//

import Foundation

protocol CalculatorRepositoryProtocol {
    func evaluate<T: Numeric>(expression: String) -> T?
}

class CalculatorRepository: CalculatorRepositoryProtocol {
    func evaluate<T: Numeric>(expression: String) -> T? {
        guard !expression.isEmpty else{return nil}
        
        let formattedExpression = expression.replacingOccurrences(of: "%", with: "*0.01") // Handling percentage
        
        let result = evaluateExpression(formattedExpression)
        
        if let intResult = result as? Int, T.self == Int.self {
            return intResult as? T
        } else if let doubleResult = result as? Double, T.self == Double.self {
            return doubleResult as? T
        }
        
        return nil
    }
    
    private func evaluateExpression(_ expression: String) -> Any? {
        let exp = NSExpression(format: expression)
        if let result = exp.expressionValue(with: nil, context: nil) as? NSNumber {
            return result.isIntegerValue() ? result.intValue : result.doubleValue
        }
        return nil
    }
}

extension NSNumber {
    func isIntegerValue() -> Bool {
        return self.doubleValue == Double(self.intValue)
    }
}
