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
        
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension MainCoordinator : MainNavigation {
    func presentRegisterImage() {
    }
}
