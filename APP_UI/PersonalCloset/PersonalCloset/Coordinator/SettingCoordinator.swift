//
//  SettingCoordinator.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/14/24.
//

import UIKit

final class SettingCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController

    func start() {
        presentSetting()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.isNavigationBarHidden = true
    }
}

extension SettingCoordinator : SettingNavigation {
    func presentSetting() {
        let settingVC = SettingViewController()
        navigationController.pushViewController(settingVC, animated: true)
    }
}
