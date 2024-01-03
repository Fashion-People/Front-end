//
//  JoinViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

class JoinViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        inputViewConfig()
        setLayout()
    }
    
    private var joinLabel : UILabel = {
        let label = UILabel()
        label.text = "Join"
        label.font =
        
        return label
    }()
    
    private let joinStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 24
        
        return stackView
    }()
    
    private var joinIDInput = JoinInputView()
    private var joinPasswordInput = JoinInputView()
    private var joinPasswordCheckInput = JoinInputView()
    private var joinNameInput = JoinInputView()
    private var joinEmailInput = JoinInputView()
    
    private func inputViewConfig() {
        joinIDInput.inputLabel.text = "아이디"
        joinIDInput.inputTextField.placeholder = "아이디를 입력해주세요"
        
        joinPasswordInput.inputLabel.text = "비밀번호"
        joinPasswordInput.inputTextField.placeholder = "비밀번호를 입력해주세요"
        
        joinPasswordCheckInput.inputLabel.text = "비밀번호 확인"
        joinPasswordCheckInput.inputTextField.placeholder = "비밀번호를 한번더 입력해주세요"
        
        joinNameInput.inputLabel.text = "이름"
        joinNameInput.inputTextField.placeholder = "이름을 입력해주세요"
        
        joinEmailInput.inputLabel.text = "이메일"
        joinEmailInput.inputTextField.placeholder = "이메일을 입력해주세요"
    }
    
    private func setLayout() {
        [joinIDInput,
         joinPasswordInput,
         joinPasswordCheckInput,
         joinNameInput,
         joinEmailInput].forEach{
            joinStackView.addArrangedSubview($0)
        }
        
        view.addSubview(joinStackView)
        
        joinStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(130)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}
