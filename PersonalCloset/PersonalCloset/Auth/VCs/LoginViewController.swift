//
//  LoginViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

protocol LoginNavigation : AnyObject {
    func presentJoinVC()
    func presentMainVC()
    func pushLoginVC()
}

final class LoginViewController : UIViewController {    
    weak var coordinator : LoginNavigation?
    
    init(coordinator: LoginNavigation) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.hideKeyboardWhenTappedAround()
        
        UIconfig()
        stackLayout()
        setLayout()
        backBarButtonConfig()
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
        stackView.alignment = .center
        stackView.spacing = 7
        
        return stackView
    }()
    
    private var IDTextField = InputView("아이디를 입력해주세요.")
    private var passwordTextField = InputView("비밀번호를 입력해주세요.")
    private let lineView = UIView()
    
    private func UIconfig() {
        lineView.backgroundColor = .bwGray
    }

    private lazy var loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.darkBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 5
        button.backgroundColor = .skyBlue
        button.addAction(
            UIAction { _ in
                self.tabLoginButton()
            },
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var joinButton : UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.darkBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGray5
        button.addAction(
            UIAction { _ in
                self.tabJoinButton()
            },
            for: .touchUpInside
        )
        
        return button
    }()
    
    private func backBarButtonConfig() {
        let backBarButtonItem = UIBarButtonItem(title: "로그인",
                                                style: .plain,
                                                target: self,
                                                action: nil)
        backBarButtonItem.tintColor = .darkBlue
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // MARK: - method
    private func tabJoinButton() {
        //join 버튼 눌렀을때
        coordinator?.presentJoinVC()
    }
    
    private func tabLoginButton() {
        // login 버튼 눌렀을때 
        coordinator?.presentMainVC()
    }

    private func stackLayout() {
        [IDTextField,
         passwordTextField].forEach {
            inputStackView.addArrangedSubview($0)
        }
    }
    
    // MARK: - UI layout config
    private func setLayout() {
        [loginLabel,
         inputStackView,
         loginButton,
         lineView,
         joinButton].forEach {
            view.addSubview($0)
        }
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(90)
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
        
        joinButton.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(30)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
            $0.width.equalTo(295)
        }
    }
}