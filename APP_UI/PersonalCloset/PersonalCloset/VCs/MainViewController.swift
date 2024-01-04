//
//  MainViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 12/30/23.
//

import UIKit
import SnapKit

class MainViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private lazy var cameraButton : UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .darkBlue
        button.layer.cornerRadius = 10
        button.backgroundColor = .skyBlue
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .light)
        let image = UIImage(systemName: "camera.fill", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)

        return button
    }()
    
    private let emptyView : UIView = {
        let view = UIView()
        view.backgroundColor = .skyBlue
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    override func setLayout() {
        super.setLayout()
        
        [cameraButton, emptyView].forEach {
            view.addSubview($0)
        }
        
        cameraButton.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(40)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-30)
            $0.height.equalTo(200)
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(cameraButton.snp.bottom).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-30)
            $0.height.equalTo(300)
        }
    }
}
