//
//  AthuCoordinator.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/14/24.
//

import UIKit

final class AuthCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController

    func start() {
        print("auth 시작")
        presentLoginVC()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.isNavigationBarHidden = true
    }
}

extension AuthCoordinator : LoginNavigation {
    func presentJoinVC() {
        let joinVC = JoinViewController()
        navigationController.pushViewController(joinVC, animated: true)
    }
    
    func presentMainVC() {
        let appCoordinator = parentCoordinator as! AppCoordinator
        appCoordinator.startMainTabbarCoordinator()
        appCoordinator.childDidFinish(self)
    }
    
    func presentLoginVC() {
        let loginVC = LoginViewController(coordinator: self)
        navigationController.pushViewController(loginVC, animated: true)
    }
}
