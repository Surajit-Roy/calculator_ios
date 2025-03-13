//
//  PerformCalculationUseCase.swift
//  CalculatorFirst
//
//  Created by Surajit on 10/02/25.
//

import Foundation

protocol PerformCalculationUseCaseProtocol {
    func calculate<T: Numeric>(expression: String) -> T?
}

class PerformCalculationUseCase: PerformCalculationUseCaseProtocol {
    private let repository: CalculatorRepositoryProtocol

    init(repository: CalculatorRepositoryProtocol) {
        self.repository = repository
    }

    func calculate<T: Numeric>(expression: String) -> T? {
        return repository.evaluate(expression: expression)
    }
}
