//
//  MainCoordinator.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/14/24.
//

import UIKit

final class MainCoordinator: Coordinator {
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

extension MainCoordinator: MainViewControllerDelegate,
                          RegisterImageViewControllerDelegate,
                          ImageResultViewControllerDelegate,
                           AddImageViewControllerDelegate {
    /// navigation push 기능
    func presentMainVC() {
        let mainVC = MainViewController()
        mainVC.delegate = self
        navigationController.pushViewController(mainVC, animated: true)
    }
    
    func presentRegisterVC() {
        let registerVC = RegisterImageViewController()
        registerVC.delegate = self
        navigationController.pushViewController(registerVC, animated: true)
    }
    
    func presentResultVC() {
        let resultVC = ImageResultViewController()
        resultVC.delegate = self
        navigationController.pushViewController(resultVC, animated: true)
    }
    
    func presentAddImageVC() {
        let addImageVC = AddImageViewController()
        addImageVC.delegate = self
        navigationController.pushViewController(addImageVC, animated: true)
    }
    
    /// navigation pop 기능
    func backToPreviousVC() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func backToRegisterVC() {
        navigationController.popViewController(animated: true)
    }
}
