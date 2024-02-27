//
//  ImageInputButton.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

final class ImageInputButton : UIView {
    lazy var inputImageButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.tintColor = .black
        button.layer.cornerRadius = 5
        
//        let imageConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .light)
//        let image = UIImage(systemName: "plus", withConfiguration: imageConfig)
//        button.setImage(image, for: .normal)
//        let titleConfig = UIFont(name: "추가", size: 15)
//        button.setTitle(titleConfig, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setLayout() {
        addSubview(inputImageButton)
        
        inputImageButton.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(170)
        }
    }
    
}
