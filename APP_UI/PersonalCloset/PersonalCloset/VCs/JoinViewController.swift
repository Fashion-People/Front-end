//
//  JoinViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

final class JoinViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.hideKeyboardWhenTappedAround()
        inputViewConfig()
        setLayout()
        navigationBarConfig()
    }
    
    // MARK: - UI config
    private let contentView = UIView()
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false

        return scrollView
    }()
    
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
        
    private var firstPickerView : JoinPickerView = {
        let pickerView = JoinPickerView()
        pickerView.inputLabel.text = "1순위"
        
        return pickerView
    }()
    
    private var secondPickerView : JoinPickerView = {
        let pickerView = JoinPickerView()
        pickerView.inputLabel.text = "2순위"
        
        return pickerView
    }()
    
    private var thirdPickerView : JoinPickerView = {
        let pickerView = JoinPickerView()
        pickerView.inputLabel.text = "3순위"
        
        return pickerView
    }()
    
    private var fourthPickerView : JoinPickerView = {
        let pickerView = JoinPickerView()
        pickerView.inputLabel.text = "4순위"
        
        return pickerView
    }()
    
    private lazy var joinButton : UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.darkBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor.skyBlue.cgColor
        button.addAction(UIAction { _ in
            self.tabJoinButton()
            }, for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - method
    private func tabJoinButton() {
        let joinSuccessAlert = UIAlertController(title: "알림",
                                                 message: "회원가입 성공.",
                                                 preferredStyle: UIAlertController.Style.alert)
        
        let success = UIAlertAction(title: "확인",
                                    style: .default) { action in
            // 회원가입 확인 버튼 눌렀을때
        }
        joinSuccessAlert.addAction(success)
        self.present(joinSuccessAlert, animated: true, completion: nil)
    }
    
    @objc private func tabJoinButtonbutton() {
        // join 버튼 눌렀을때 
    }
    
    private func navigationBarConfig() {
        navigationController?.isNavigationBarHidden = false
        let backButton = UIBarButtonItem(image: UIImage(systemName:"chevron.backward"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(tabJoinButtonbutton))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.title = "로그인"
        navigationItem.leftBarButtonItem?.tintColor = .darkBlue
    }
    
    // MARK: - UI layout config
    private func setLayout() {
        [joinIDInput,
         joinPasswordInput,
         joinPasswordCheckInput,
         joinNameInput,
         joinEmailInput].forEach{
            joinStackView.addArrangedSubview($0)
        }
        
        [joinLabel,
         scrollView,
         joinButton].forEach{
            view.addSubview($0)
        }
        
        scrollView.addSubview(contentView)
        
        [joinStackView,
         firstPickerView,
         secondPickerView,
         thirdPickerView,
         fourthPickerView].forEach {
            contentView.addSubview($0)
        }
        
        joinLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(joinLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(joinButton.snp.top).offset(-10)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(1150)
        }
        
        joinStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.bottom.equalTo(firstPickerView.snp.top).offset(-10)
        }
        
        firstPickerView.snp.makeConstraints {
            $0.top.equalTo(joinStackView.snp.bottom).offset(10)
            $0.height.equalTo(150)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        secondPickerView.snp.makeConstraints {
            $0.top.equalTo(firstPickerView.snp.bottom).offset(10)
            $0.height.equalTo(150)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        thirdPickerView.snp.makeConstraints {
            $0.top.equalTo(secondPickerView.snp.bottom).offset(10)
            $0.height.equalTo(150)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        fourthPickerView.snp.makeConstraints {
            $0.top.equalTo(thirdPickerView.snp.bottom).offset(10)
            $0.height.equalTo(150)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        joinButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-40)
            $0.height.equalTo(40)
            $0.width.equalTo(310)
        }
    }
}

