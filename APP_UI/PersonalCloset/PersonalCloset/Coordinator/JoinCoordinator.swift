//
//  JoinCoordinator.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/7/24.
//

import UIKit

protocol JoinCoordinatorDelegate {
    func didPresentLoginView(_ coordinator: JoinCoordinator)
}

class JoinCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var delegate : JoinCoordinatorDelegate?
    
    private var navigationController : UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = JoinViewController()
        viewController.delegate = self
        
        self.navigationController.viewControllers = [viewController]
    }
}

extension JoinCoordinator : JoinViewControllerDelegate {
    func backToLogin() {
        self.delegate?.didPresentLoginView(self)
    }
}
