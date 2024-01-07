//
//  MainCoordinator.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/7/24.
//

import UIKit

protocol MainCoordinatorDelegate {
    func didPresentRegister(_ coordinator : MainCoordinator)
}

class MainCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var delegate : MainCoordinatorDelegate?
    
    private var navigationController : UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MainViewController()
        viewController.delegate = self
        
        self.navigationController.viewControllers = [viewController]
    }
}

extension MainCoordinator : MainViewControllerDelegate {
    func presentRegister() {
        self.delegate?.didPresentRegister(self)
    }
}

