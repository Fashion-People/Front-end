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
        print("메인 코디네이터 시작")
        presentMainVC()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.isNavigationBarHidden = true
    }
}

extension MainCoordinator : MainNavigation {
    func presentMainVC() {
        let mainVC = MainViewController()
        navigationController.pushViewController(mainVC, animated: true)
    }
}
