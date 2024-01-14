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
        
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension AuthCoordinator : LoginNavigation {
    func presentJoinVC() {
    }
    
    func presentMainVC() {
        <#code#>
    }
    
    func goToLogin() {
        <#code#>
    }
}
