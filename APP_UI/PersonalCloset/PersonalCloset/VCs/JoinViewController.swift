//
//  JoinViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

protocol JoinViewControllerDelegate {
    func backToLogin()
}

final class JoinViewController : UIViewController {
    var delegate : JoinViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.hideKeyboardWhenTappedAround()
        inputViewConfig()
        setLayout()
        navigationItem.backBarButtonItem?.action = #selector(tabJoinButtonbutton)
    }
    
    private var joinLabel : UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.font = UIFont.systemFont(ofSize: 33, weight: .heavy)
        label.textColor = .darkBlue
        
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
    
    private lazy var joinButton : UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.darkBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 5
        button.backgroundColor = .skyBlue
        button.addAction(UIAction { _ in
            self.tabJoinButton()
            }, for: .touchUpInside
        )
        
        return button
    }()
    // MARK: - method
    
    private func tabJoinButton() {
        let joinSuccessAlert = UIAlertController(title: "알림",
                                                 message: "회원가입 성공.",
                                                 preferredStyle: UIAlertController.Style.alert)
        
        let success = UIAlertAction(title: "확인",
                                    style: .default) { action in
            self.delegate?.backToLogin()
        }
        joinSuccessAlert.addAction(success)
        self.present(joinSuccessAlert, animated: true, completion: nil)
    }
    
    @objc private func tabJoinButtonbutton() {
        let joinSuccessAlert = UIAlertController(title: "알림",
                                                 message: "회원가입 성공.",
                                                 preferredStyle: UIAlertController.Style.alert)
        
        let success = UIAlertAction(title: "확인",
                                    style: .default) { action in
            self.delegate?.backToLogin()
        }
        joinSuccessAlert.addAction(success)
        self.present(joinSuccessAlert, animated: true, completion: nil)
    }

    
    private func setLayout() {
        [joinIDInput,
         joinPasswordInput,
         joinPasswordCheckInput,
         joinNameInput,
         joinEmailInput].forEach{
            joinStackView.addArrangedSubview($0)
        }
        
        [joinLabel,
         joinStackView,
         joinButton].forEach{
            view.addSubview($0)
        }
        
        joinLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
        }
        
        joinStackView.snp.makeConstraints {
            $0.top.equalTo(joinLabel.snp.bottom).offset(40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        joinButton.snp.makeConstraints {
            $0.top.equalTo(joinStackView.snp.bottom).offset(80)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
            $0.width.equalTo(310)
        }
        
    }
}
