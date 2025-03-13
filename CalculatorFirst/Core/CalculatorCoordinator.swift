//
//  CalculatorCoordinator.swift
//  CalculatorFirst
//
//  Created by Surajit on 10/02/25.
//

import Foundation
import UIKit

protocol CalculatorCoordinatorProtocol {
    func start()
}

class CalculatorCoordinator: CalculatorCoordinatorProtocol {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let calculatorVC = CalculatorViewController()
        navigationController.pushViewController(calculatorVC, animated: true)
    }
}
