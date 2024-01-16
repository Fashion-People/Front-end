//
//  MainCoordinator.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/14/24.
//

import UIKit

final class MainCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController

    func start() {
        presentMainVC()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.isNavigationBarHidden = true
    }
}

extension MainCoordinator : MainNavigation, RegisterImageNavigation, ImageResultNavigation {
    // navigation push 기능
    func presentMainVC() {
        let mainVC = MainViewController(coordinator: self)
        navigationController.pushViewController(mainVC, animated: true)
    }
    
    func presentRegisterVC() {
        let registerVC = RegisterImageViewController(coordinator: self)
        navigationController.pushViewController(registerVC, animated: true)
    }
    
    func presentResultVC() {
        let resultVC = ImageResultViewController(coordinator: self)
        navigationController.pushViewController(resultVC, animated: true)
    }
    
    // navigation pop 기능
    func backToMainVC() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func backToRegisterVC() {
        navigationController.popViewController(animated: true)
    }

}
