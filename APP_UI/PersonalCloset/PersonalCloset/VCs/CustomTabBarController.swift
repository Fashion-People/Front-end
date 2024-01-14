//
//  TabBarController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 12/30/23.
//

import UIKit

class CustomTabBarController : UITabBarController {
//    let mainVC = MainViewController()
//    let settingVC = SettingViewController()
//    let registerVC = RegisterImageViewController()
    
    override func viewDidLoad() {
        tabBarConfig()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 95
        tabFrame.origin.y = self.view.frame.size.height - 95
        self.tabBar.frame = tabFrame
    }

    private var buttonStackView = ButtonStackView()
    
    private func tabBarConfig() {
        self.tabBar.layer.backgroundColor = UIColor.skyBlue.cgColor
        self.tabBar.layer.cornerRadius = 20
        
        tabBar.addSubview(buttonStackView)
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-15)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
}
