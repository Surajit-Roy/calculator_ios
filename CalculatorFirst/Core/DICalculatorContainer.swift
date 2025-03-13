//
//  DIContainer.swift
//  CalculatorFirst
//
//  Created by Surajit on 10/02/25.
//

import Foundation


class DICalculatorContainer {
    static let shared = DICalculatorContainer()
    
    private init() {}
    
    lazy var calculatorRepository: CalculatorRepositoryProtocol = CalculatorRepository()
    
    lazy var performCalculationUseCase: PerformCalculationUseCaseProtocol =
        PerformCalculationUseCase(repository: calculatorRepository)

    func makeCalculatorViewModel() -> CalculatorViewModel {
        return CalculatorViewModel(useCase: performCalculationUseCase)
    }
}
