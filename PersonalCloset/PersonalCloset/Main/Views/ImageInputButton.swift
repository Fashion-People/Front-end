//
//  ImageInputButton.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

final class ImageInputButton: UIView {
    private enum Metric {
        static let height: CGFloat = 170
    }
    
    lazy var inputImageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.tintColor = .black
        button.layer.cornerRadius = 5
                
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
            $0.height.equalTo(Metric.height)
        }
    }
    
}
