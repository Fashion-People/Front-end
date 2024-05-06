//
//  TopView.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit


final class TopView: UIView {
    init() {
        super.init(frame: .zero)
        self.setupLayouts()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .darkBlue
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return button
    }()
    
    private lazy var iconButton: UIButton = {
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
    
    /// private 변경할 수 있는 방법이 없을까?
    lazy var selectButton: UIButton = {
        let button = UIButton()
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 25,
                                                      weight: .medium,
                                                      scale: .medium)
        
        let buttonImage = UIImage(systemName: "checkmark", withConfiguration: imageConfig)
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .lightGray
        
        return button
    }()
    
    lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return image
    }()
    
    // MARK: - setup Layout
    private func setupLayouts() {
        [iconButton,
         selectButton,
         weatherImage].forEach {
            topStackView.addArrangedSubview($0)
        }
        
        [weatherImage,
         selectButton].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(35)
                $0.height.equalTo(30)
            }
        }
        
        [backButton,
         topStackView].forEach {
            addSubview($0)
        }
    }
    
    // MARK: - UI Constraints config
    private func setupConstraints() {
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


