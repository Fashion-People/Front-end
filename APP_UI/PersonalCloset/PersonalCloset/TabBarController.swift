//
//  TabBarController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 12/30/23.
//

import UIKit

class TabBarController : UITabBarController {
    let mainVC = MainViewController()
    let registerVC = RegisterImageViewController()
    let settingVC = SettingViewController()
    
    override func viewDidLoad() {
        setupVC()
        layout()
    }
    
    private func setupVC() {        
        let mainTabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)
        let registerImageTabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "hanger"), tag: 0)
        let settingTabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person"), tag: 0)

        mainVC.tabBarItem = mainTabBarItem
        registerVC.tabBarItem = registerImageTabBarItem
        settingVC.tabBarItem = settingTabBarItem

        setViewControllers([mainVC,registerVC,settingVC], animated: true)
    }
    
    private func layout() {
        self.tabBar.backgroundColor = .skyBlue
        self.tabBar.tintColor = .darkBlue
    }
}
