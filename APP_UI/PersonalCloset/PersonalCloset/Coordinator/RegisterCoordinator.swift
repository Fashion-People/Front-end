//
//  RegisterCoordinator.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/7/24.
//

import UIKit

protocol RegisterCoordinatorDelegate {
    func didPresentMain(_ coordinator: RegisterCoordinator)
    func didPresentResult(_ coordinator: RegisterCoordinator)
}

class RegisterCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var delegate : RegisterCoordinatorDelegate?
    
    private var navigationController : UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = RegisterImageViewController()
        viewController.delegate = self
        
        self.navigationController.viewControllers = [viewController]
    }
}

extension RegisterCoordinator : RegisterImageViewControllerDelegate {
    func backToMain() {
        self.delegate?.didPresentMain(self)
    }
    
    func presentResult(){
        self.delegate?.didPresentResult(self)
    }
    
}
