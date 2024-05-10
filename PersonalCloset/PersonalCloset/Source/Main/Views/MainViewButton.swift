//
//  MainViewButton.swift
//  PersonalCloset
//
//  Created by Bowon Han on 5/10/24.
//

import UIKit
import SnapKit

final class MainViewButton: UIView {
    private let imageName: String
    var actionEvent: UIAction
    
    init(imageName: String, action: UIAction) {
        self.actionEvent = action
        self.imageName = imageName
        super.init(frame: .zero)
        self.setupLayouts()
        self.button.addAction(actionEvent, for: .touchUpInside)
    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .darkBlue
        button.layer.cornerRadius = 10
        button.backgroundColor = .skyBlue
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .light)
        let image = UIImage(systemName: imageName, withConfiguration: imageConfig)
        button.setImage(image, for: .normal)

        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupLayouts() {
        self.layer.shadowColor = UIColor(hexCode: "c4c4c4").cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 7
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)

        self.button.layer.cornerRadius = 10
        self.button.layer.masksToBounds = true
        self.button.backgroundColor = .skyBlue
        
        addSubview(button)
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
