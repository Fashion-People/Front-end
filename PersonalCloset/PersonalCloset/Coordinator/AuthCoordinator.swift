//
//  AthuCoordinator.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/14/24.
//

import UIKit

final class AuthCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController

    func start() {
        pushLoginVC()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.isNavigationBarHidden = true
    }
}

extension AuthCoordinator: LoginViewControllerDelegate,
                          JoinViewControllerDelegate {
    func presentMainVC() {
        let appCoordinator = parentCoordinator as! AppCoordinator
        appCoordinator.startMainTabbarCoordinator()
        appCoordinator.childDidFinish(self)
    }
    
    func pushLoginVC() {
        let loginVC = LoginViewController()
        loginVC.delegate = self
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func presentJoinVC() {
        let joinVC = JoinViewController()
        joinVC.delegate = self
        navigationController.pushViewController(joinVC, animated: true)
    }
    
    func backToLoginVC() {
        navigationController.popViewController(animated: true)
    }
}
