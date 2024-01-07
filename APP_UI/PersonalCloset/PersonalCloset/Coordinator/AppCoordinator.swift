//
//  AppCoordinator.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/7/24.
//

import UIKit

protocol Coordinator : AnyObject {
    var childCoordinators : [Coordinator] { get set }
    func start()
}

class AppCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    private var navigationController : UINavigationController!
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.showResultViewController()
    }
    
    private func showMainViewController() {
        let coordinator = MainCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        coordinator.start()
        
        self.childCoordinators.append(coordinator)
    }
    
    private func showLoginViewController() {
        let coordinator = LoginCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        coordinator.start()
        
        self.childCoordinators.append(coordinator)
    }
    
    private func showJoinViewController() {
        let coordinator = JoinCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        coordinator.start()
        
        self.childCoordinators.append(coordinator)
    }
    
    private func showResultViewController() {
        let coordinator = ResultCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        coordinator.start()
        
        self.childCoordinators.append(coordinator)
    }
    
    private func showRegisterViewController() {
        let coordinator = RegisterCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        coordinator.start()
        
        self.childCoordinators.append(coordinator)
    }
    
    private func showTabBarViewController() {
        let coordinator = TabBarCoordinator(navigationController: self.navigationController)
        coordinator.start()
        
        self.childCoordinators.append(coordinator)
    }
}

extension AppCoordinator : MainCoordinatorDelegate {
    func didPresentRegister(_ coordinator: MainCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showRegisterViewController()
    }
}

extension AppCoordinator : LoginCoordinatorDelegate {
    func didJoined(_ coordinator: LoginCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showLoginViewController()
    }
    
    func didLoggedIn(_ coordinator: LoginCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showMainViewController()
    }
}

extension AppCoordinator : JoinCoordinatorDelegate {
    func didPresentLoginView(_ coordinator: JoinCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showLoginViewController()
    }
}

extension AppCoordinator : ResultCoordinatorDelegate {
    func didAgainCheckResult(_ coordinator: ResultCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showRegisterViewController()
    }
    
    func didPresentMain(_ coordinator: ResultCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showMainViewController()
    }
}

extension AppCoordinator : RegisterCoordinatorDelegate {
    func didPresentMain(_ coordinator: RegisterCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showMainViewController()
    }
    
    func didPresentResult(_ coordinator: RegisterCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showResultViewController()
    }
}


