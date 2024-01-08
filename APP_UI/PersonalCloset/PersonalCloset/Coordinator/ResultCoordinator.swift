//
//  ResultCoordinator.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/7/24.
//

import UIKit

protocol ResultCoordinatorDelegate {
    func didPresentMain(_ coordinator: ResultCoordinator)
    func didPresentRegister(_ coordinator: ResultCoordinator)
}

class ResultCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var delegate : ResultCoordinatorDelegate?
    
    private var navigationController : UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ImageResultViewController()
        viewController.delegate = self
        
        self.navigationController.viewControllers = [viewController]
    }
}

extension ResultCoordinator : ImageResultViewControllerDelegate {
    func backToMain() {
        self.delegate?.didPresentMain(self)
    }
    
    func backToRegister() {
        self.delegate?.didPresentRegister(self)
    }
}

