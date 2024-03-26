//
//  JoinViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

protocol JoinViewControllerDelegate : AnyObject {
    func backToLoginVC()
}

final class JoinViewController : UIViewController {
    weak var delegate : JoinViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.hideKeyboardWhenTappedAround()
        setLayout()
        navigationBarConfig()
        setupStyles()
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
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 24
        
        return stackView
    }()
    
    private var joinIDInput = JoinInputView(placeholder: "아이디를 입력해주세요",
                                                guide: "아이디")
    private var joinPasswordInput = JoinInputView(placeholder: "비밀번호를 입력해주세요",
                                                  guide: "비밀번호")
    private var joinPasswordCheckInput = JoinInputView(placeholder: "비밀번호를 한번더 입력해주세요",
                                                       guide: "비밀번호 확인")
    private var joinNameInput = JoinInputView(placeholder: "이름을 입력해주세요",
                                              guide: "이름")
    private var joinEmailInput = JoinInputView(placeholder: "이메일을 입력해주세요",
                                               guide: "이메일")

    private var firstPickerView = JoinPickerView("1순위")
    private var secondPickerView = JoinPickerView("2순위")
    private var thirdPickerView = JoinPickerView("3순위")
    private var fourthPickerView = JoinPickerView("4순위")
    
    private lazy var joinButton = PersonalClosetButton("회원가입",titleColor: .darkBlue,
                                                       backColor: .skyBlue,
                                                       action: UIAction { _ in
                                                                    self.tapJoinButton()
                                                                })
        
    // MARK: - method
    @objc private func tabBackbutton() {
        // back 버튼 눌렀을때
        delegate?.backToLoginVC()
    }
    
    private func tapJoinButton() {
        let id: String = joinIDInput.inputTextField.text ?? ""
        let password: String = joinPasswordInput.inputTextField.text ?? ""
        let passwordCheck: String = joinPasswordCheckInput.inputTextField.text ?? ""
        let name: String = joinNameInput.inputTextField.text ?? ""
        let email: String = joinEmailInput.inputTextField.text ?? ""
        let style1: String = firstPickerView.first
        let style2: String = secondPickerView.second
        let style3: String = thirdPickerView.third
        let style4: String = fourthPickerView.fourth
        
        var joinSuccess = false
        
        let requestBody = UserRequestDTO(
            email: email,
            loginId: id,
            name: name,
            password: password,
            style1: style1,
            style2: style2,
            style3: style3,
            style4: style4
        )
        
        Task {
            joinSuccess = try await TokenAPI.join(requestBody).performRequest(with: requestBody)
            
            if joinSuccess == true {
                let joinSuccessAlert = UIAlertController(title: "알림",
                                                         message: "회원가입 성공.",
                                                         preferredStyle: UIAlertController.Style.alert)
                
                let success = UIAlertAction(title: "확인",
                                            style: .default) { action in
                    self.delegate?.backToLoginVC()
                }
                
                joinSuccessAlert.addAction(success)
                self.present(joinSuccessAlert, animated: true, completion: nil)
            }
            else {
                ///
            }
        }
    }
    
    private func setupStyles() {
        joinPasswordInput.inputTextField.isSecureTextEntry = true
        joinPasswordInput.inputTextField.textContentType = .oneTimeCode
        
        joinPasswordCheckInput.inputTextField.isSecureTextEntry = true
        joinPasswordCheckInput.inputTextField.textContentType = .oneTimeCode
    }
    
    private func navigationBarConfig() {
        navigationController?.isNavigationBarHidden = false
        let backButton = UIBarButtonItem(image: UIImage(systemName:"chevron.backward"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(tabBackbutton))
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
         joinEmailInput,
         firstPickerView,
         secondPickerView,
         thirdPickerView,
         fourthPickerView].forEach{
            joinStackView.addArrangedSubview($0)
        }
        
        [joinLabel,
         scrollView,
         joinButton].forEach{
            view.addSubview($0)
        }
        
        scrollView.addSubview(contentView)
        
        [joinStackView].forEach {
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
        }
                
        joinButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(300)
        }
    }
}

