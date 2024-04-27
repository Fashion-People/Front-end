//
//  LoginViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

protocol LoginViewControllerDelegate: AnyObject {
    func presentJoinVC()
    func presentMainVC()
    func pushLoginVC()
}

final class LoginViewController: UIViewController {    
    weak var delegate: LoginViewControllerDelegate?
    
    private enum Metric {
        enum LoginLabel {
            static let top: CGFloat = 90
        }
         
        enum InputView {
            static let spacing: CGFloat = 7
            static let top: CGFloat = 30
            static let sideInset: CGFloat = 50
        }
        
        enum LoginDescription {
            static let top: CGFloat = 5
            static let height: CGFloat = 20
        }
        
        enum Buttons {
            static let top: CGFloat = 30
            static let height: CGFloat = 40
        }
        
        enum LineView {
            static let top: CGFloat = 20
            static let height: CGFloat = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.hideKeyboardWhenTappedAround()
        
        setupStackLayout()
        setupLayout()
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
    
    private lazy var loginButton = PersonalClosetButton("로그인",
                                                    titleColor:.darkBlue,
                                                    backColor: .skyBlue,
                                                    action: UIAction { _ in
                                                                self.tapLoginButton()
                                                            })
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .bwGray
        
        return view
    }()
    
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
    private func setupStackLayout() {
        [IDTextField,
         passwordTextField].forEach {
            inputStackView.addArrangedSubview($0)
        }
    }
    
    private func setupLayout() {
        [loginLabel,
         inputStackView,
         loginDescription,
         loginButton,
         lineView,
         joinButton].forEach {
            view.addSubview($0)
        }
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Metric.LoginLabel.top)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        [IDTextField, passwordTextField].forEach {
            $0.snp.makeConstraints {
                $0.leading.equalTo(inputStackView.snp.leading)
                $0.trailing.equalTo(inputStackView.snp.trailing)
            }
        }
        
        inputStackView.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(Metric.InputView.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.InputView.sideInset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.InputView.sideInset)
        }
        
        loginDescription.snp.makeConstraints {
            $0.top.equalTo(inputStackView.snp.bottom).offset(Metric.LoginDescription.top)
            $0.leading.equalTo(inputStackView.snp.leading)
            $0.height.equalTo(Metric.LoginDescription.height)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(loginDescription.snp.bottom).offset(Metric.Buttons.top)
            $0.leading.equalTo(inputStackView.snp.leading)
            $0.trailing.equalTo(inputStackView.snp.trailing)
            $0.height.equalTo(Metric.Buttons.height)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(Metric.LineView.top)
            $0.leading.equalTo(loginButton.snp.leading)
            $0.trailing.equalTo(loginButton.snp.trailing)
            $0.height.equalTo(Metric.LineView.height)
        }
        
        joinButton.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(Metric.Buttons.top)
            $0.leading.equalTo(lineView.snp.leading)
            $0.trailing.equalTo(lineView.snp.trailing)
            $0.height.equalTo(Metric.Buttons.height)
        }
    }
}
