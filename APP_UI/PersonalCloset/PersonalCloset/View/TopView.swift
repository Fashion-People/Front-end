//
//  TopView.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit


class TopView : UIView {
    private let topStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .darkBlue
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return button
    }()
    
    private lazy var iconButton : UIButton = {
        let button = UIButton()
        button.setTitle("Personal\nCloset", for: .normal)
        button.setTitleColor(.darkBlue, for: .normal)
        button.contentHorizontalAlignment = .leading
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = .center
        
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)

        return button
    }()
    
    private var weatherImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "sun.rain")
        image.tintColor = .black
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setLayout() {
        [iconButton,
         weatherImage].forEach {
            topStackView.addArrangedSubview($0)
        }
        
        iconButton.snp.makeConstraints {
            $0.width.equalTo(200)
        }
        
        weatherImage.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        
        [backButton,topStackView].forEach {
            addSubview($0)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.width.equalTo(20)
            $0.height.equalTo(45)
            $0.centerY.equalTo(self)
        }
                
        topStackView.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(45)
            $0.centerY.equalTo(self)

        }
    }
}


