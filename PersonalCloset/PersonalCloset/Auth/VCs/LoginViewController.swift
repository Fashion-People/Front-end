//
//  LoginViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

protocol LoginViewControllerDelegate : AnyObject {
    func presentJoinVC()
    func presentMainVC()
    func pushLoginVC()
}

final class LoginViewController : UIViewController {    
    weak var delegate : LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.hideKeyboardWhenTappedAround()
        
        UIconfig()
        stackLayout()
        setLayout()
        backBarButtonConfig()
        setupStyles()
    }
    
    // MARK: - UI config
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
        stackView.alignment = .leading
        stackView.spacing = 7
        
        return stackView
    }()
    
    private var IDTextField = InputView("아이디를 입력해주세요.")
    private var passwordTextField = InputView("비밀번호를 입력해주세요.")
    
    private var loginDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textColor = .red
        
        return label
    }()
    
    private func UIconfig() {
        lineView.backgroundColor = .bwGray
    }

    private lazy var loginButton = PersonalClosetButton("로그인",
                                                    titleColor:.darkBlue,
                                                    backColor: .skyBlue,
                                                    action: UIAction { _ in
                                                                self.tapLoginButton()
                                                            })
    
    private let lineView = UIView()
    
    private lazy var joinButton = PersonalClosetButton("회원가입",
                                                    titleColor:.darkBlue,
                                                    backColor: .systemGray5,
                                                    action: UIAction { _ in
                                                                self.delegate?.presentJoinVC()
                                                            })
    
    private func backBarButtonConfig() {
        let backBarButtonItem = UIBarButtonItem(title: "로그인",
                                                style: .plain,
                                                target: self,
                                                action: nil)
        backBarButtonItem.tintColor = .darkBlue
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    private func setupStyles() {
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .oneTimeCode
    }
    
    private func tapLoginButton() {
        var loginSuccess = false
        
        let id: String = IDTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        
        if (IDTextField.text == "" ||
            passwordTextField.text == "") {
            loginDescription.text = "이메일과 비밀번호를 입력해주세요"
        }
        
        else {
            Task {
                loginSuccess = try await TokenAPI.login(id, password).performRequest()
                
                if loginSuccess == true {
                    self.delegate?.presentMainVC()
                    print("로그인 성공")
                }
                else {
                    loginDescription.text = "아이디와 비밀번호를 다시 입력해주세요."
                }
            }
        }
    }
    
    // MARK: - UI layout config
    private func stackLayout() {
        [IDTextField,
         passwordTextField].forEach {
            inputStackView.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        [loginLabel,
         inputStackView,
         loginDescription,
         loginButton,
         lineView,
         joinButton].forEach {
            view.addSubview($0)
        }
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(90)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        [IDTextField, passwordTextField].forEach {
            $0.snp.makeConstraints {
                $0.leading.equalTo(inputStackView.snp.leading)
                $0.trailing.equalTo(inputStackView.snp.trailing)
            }
        }
        
        inputStackView.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-50)
        }
        
        loginDescription.snp.makeConstraints {
            $0.top.equalTo(inputStackView.snp.bottom).offset(5)
            $0.leading.equalTo(inputStackView.snp.leading)
            $0.height.equalTo(20)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(loginDescription.snp.bottom).offset(30)
            $0.leading.equalTo(inputStackView.snp.leading)
            $0.trailing.equalTo(inputStackView.snp.trailing)
            $0.height.equalTo(40)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.leading.equalTo(loginButton.snp.leading)
            $0.trailing.equalTo(loginButton.snp.trailing)
            $0.height.equalTo(1)
        }
        
        joinButton.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(30)
            $0.leading.equalTo(lineView.snp.leading)
            $0.trailing.equalTo(lineView.snp.trailing)
            $0.height.equalTo(40)
        }
    }
}
