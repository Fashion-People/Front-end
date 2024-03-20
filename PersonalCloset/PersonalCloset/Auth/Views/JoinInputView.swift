//
//  JoinInputView.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/3/24.
//

import UIKit
import SnapKit

final class JoinInputView : UIView {
    private let customPlaceholder: String
    private let customGuide: String
    
    init(placeholder: String, guide: String) {
        self.customPlaceholder = placeholder
        self.customGuide = guide
        super.init(frame: .zero)
        
        self.setLayout()
        self.setupStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let inputStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        
        return stackView
    }()
    
    private var inputLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        return label
    }()
    
    private var inputTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect

        return textField
    }()
        
    private func setupStyles() {
        self.inputTextField.placeholder = customPlaceholder
        self.inputLabel.text = customGuide
    }
    
    private func setLayout() {
        [inputLabel,inputTextField].forEach {
            inputStackView.addArrangedSubview($0)
        }
        
        inputTextField.snp.makeConstraints {
            $0.width.equalTo(380)
            $0.height.equalTo(50)
        }
        
        addSubview(inputStackView)
        
        inputStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
