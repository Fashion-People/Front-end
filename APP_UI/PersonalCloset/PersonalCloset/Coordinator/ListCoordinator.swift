//
//  ListCoordinator.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/17/24.
//

import UIKit

final class ListCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController

    func start() {
        presentListVC()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.isNavigationBarHidden = true
    }
}

extension ListCoordinator : ListNavigation {
    func presentListVC() {
        let listVC = ClothListViewController(coordinator: self)
        navigationController.pushViewController(listVC, animated: true)
    }
    
    func backToMain() {
        navigationController.popToRootViewController(animated: true)
    }
}
