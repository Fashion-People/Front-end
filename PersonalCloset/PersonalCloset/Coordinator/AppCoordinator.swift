//
//  AppCoordinator.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/14/24.
//

import UIKit

protocol Coordinator : AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinator: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    func start()
}

extension Coordinator {
    /// Removing a coordinator inside a children. This call is important to prevent memory leak.
    /// - Parameter coordinator: Coordinator that finished.
    func childDidFinish(_ coordinator : Coordinator){
        // Call this if a coordinator is done.
        for (index, child) in childCoordinator.enumerated() {
            if child === coordinator {
                childCoordinator.remove(at: index)
                break
            }
        }
    }
}


final class AppCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController

    func start() {
        startAuthCoordinator()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.isNavigationBarHidden = true
    }
    
    func startAuthCoordinator() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        childCoordinator.removeAll()
        authCoordinator.parentCoordinator = self
        childCoordinator.append(authCoordinator)
        authCoordinator.start()
    }
    
    func startMainTabbarCoordinator() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        childCoordinator.removeAll()
        tabBarCoordinator.parentCoordinator = self
        tabBarCoordinator.start()
    }
}
