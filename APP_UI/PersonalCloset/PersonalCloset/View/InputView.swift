//
//  InputView.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/3/24.
//

import UIKit
import SnapKit

//class InputView : UIView {
//    var inputTextField : UITextField = {
//        let textField = UITextField()
//        textField.borderStyle = .roundedRect
//        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 0.0))
//
//        return textField
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setLayout()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//    
//    private func setLayout() {
//        addSubview(inputTextField)
//        
//        inputTextField.snp.makeConstraints {
//            $0.top.bottom.leading.trailing.equalToSuperview()
//            $0.height.equalTo(50)
//            $0.width.equalTo(295)
//        }
//    }
//}
 

final class InputView : UITextField {
    private let customPlaceholder: String
    
    init(_ placeholder: String) {
        self.customPlaceholder = placeholder
        super.init(frame: .zero)
        self.setupStyles()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyles() {
        self.borderStyle = .roundedRect
        self.placeholder = customPlaceholder
    }
    
    private func setupConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(300)
        }
    }
}

