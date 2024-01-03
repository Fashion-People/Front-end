//
//  LoginViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

final class LoginViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        stackLayout()
        setLayout()
    }
    
    private var loginLabel : UILabel = {
        let label = UILabel()
        label.text = "Personal\ncloset"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.textColor = .darkBlue
        
        return label
    }()
    
    private let inputStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 7
        
        return stackView
    }()
    
    private var IDTextField : InputView = {
        let input = InputView()
        input.inputTextField.placeholder = "아이디를 입력해주세요."

        return input
    }()
    
    private var passwordTextField : InputView = {
        let input = InputView()
        input.inputTextField.placeholder = "비밀번호를 입력해주세요."

        return input
    }()
    
    private lazy var loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.darkBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.layer.cornerRadius = 5
        button.backgroundColor = .skyBlue
        
        return button
    }()
    
    private let lineView : UIView = {
        let line = UIView()
        line.backgroundColor = .bwGray
        
        return line
    }()
    
    private let findStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let findID : UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        return button
    }()
    
    private let findPassword : UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        return button
    }()
    
    private lazy var joinButton : UIButton = {
        let button = UIButton()
        button.setTitle("Join", for: .normal)
        button.setTitleColor(.darkBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.layer.cornerRadius = 5
        button.backgroundColor = .skyBlue
        
        return button
    }()

    
    private func stackLayout() {
        [IDTextField,
         passwordTextField].forEach {
            inputStackView.addArrangedSubview($0)
        }
        
        [findID,
         findPassword].forEach {
            findStackView.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        [loginLabel,
         inputStackView,
         loginButton,
         lineView,
         findStackView,
         joinButton].forEach {
            view.addSubview($0)
        }
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        inputStackView.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(30)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(inputStackView.snp.bottom).offset(30)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
            $0.width.equalTo(295)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
            $0.width.equalTo(295)
        }
        
        findStackView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(15)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(280)
        }
        
        joinButton.snp.makeConstraints {
            $0.top.equalTo(findStackView.snp.bottom).offset(50)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(295)
        }
    }
}
