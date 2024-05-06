//
//  JoinViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

protocol JoinViewControllerDelegate: AnyObject {
    func backToLoginVC()
}

final class JoinViewController: UIViewController {
    weak var delegate: JoinViewControllerDelegate?
    private var firstPriority: String = "모던"
    private var secondPriority: String = "캐주얼"
    private var thirdPriority: String = "스포티"
    private var fourthPriority: String = "페미닌"
    
    private enum Metric {
        enum JoinTitle {
            static let top: CGFloat = 20
            static let leading: CGFloat = 25
        }
        
        enum ScrollView {
            static let top: CGFloat = 10
            static let bottom: CGFloat = -10
            static let contentViewHeight: CGFloat = 1100
        }
        
        enum StackView {
            static let top: CGFloat = 5
            static let leading: CGFloat = 25
            static let trailing: CGFloat = -25
        }
        
        enum PasswordDescription {
            static let top: CGFloat = 5
        }
        
        enum StackView2 {
            static let top: CGFloat = 25
        }
        
        enum JoinButton {
            static let sideInset: CGFloat = 20
            static let bottom: CGFloat = -10
            static let height: CGFloat = 50
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.hideKeyboardWhenTappedAround()
        self.setupLayouts()
        self.setupConstraints()
        self.setupStyles()
        self.navigationBarConfig()
    }
    
    // MARK: - UI config
    private let contentView = UIView()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
//        scrollView.updateContentSize()

        return scrollView
    }()
    
    private var joinLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.font = UIFont.systemFont(ofSize: 33, weight: .heavy)
        label.textColor = .darkBlue
        
        return label
    }()
    
    private let joinStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 24
        
        return stackView
    }()
    
    private let joinStackView2: UIStackView = {
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
    private var passwordDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textColor = .red

        return label
    }()
    
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
        let style1: String = firstPickerView.style
        let style2: String = secondPickerView.style
        let style3: String = thirdPickerView.style
        let style4: String = fourthPickerView.style
        
        var joinSuccess: Bool = false
        
        if password == passwordCheck {
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
                
                DispatchQueue.main.async {
                    print(joinSuccess)

                    switch joinSuccess {
                    case true:
                        let joinSuccessAlert = UIAlertController(title: "알림",
                                                                 message: "회원가입 성공.",
                                                                 preferredStyle: UIAlertController.Style.alert)
                        
                        let success = UIAlertAction(title: "확인",
                                                    style: .default) { action in
                            self.delegate?.backToLoginVC()
                        }
                        
                        joinSuccessAlert.addAction(success)
                        self.present(joinSuccessAlert, animated: true, completion: nil)
                        
                    case false:
                        let joinFailureAlert = UIAlertController(title: "알림",
                                                                 message: "회원가입 실패.",
                                                                 preferredStyle: UIAlertController.Style.alert)
                        
                        let failure = UIAlertAction(title: "확인",
                                                    style: .destructive) { action in
                            self.dismiss(animated: true)
                        }
                        
                        joinFailureAlert.addAction(failure)
                        self.present(joinFailureAlert, animated: true, completion: nil)
                    }
                }
            }
        }
        
        else {
            /// 비밀번호 !=  비밀번호 확인란
            passwordDescription.text = "비밀번호를 확인해주세요."
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
    private func setupLayouts() {
        [joinIDInput,
         joinPasswordInput,
         joinPasswordCheckInput].forEach{
            joinStackView.addArrangedSubview($0)
        }
        
        [joinNameInput,
         joinEmailInput,
         firstPickerView,
         secondPickerView,
         thirdPickerView,
         fourthPickerView].forEach {
            joinStackView2.addArrangedSubview($0)
        }
        
        [joinLabel,
         scrollView,
         joinButton].forEach{
            view.addSubview($0)
        }
        
        scrollView.addSubview(contentView)
        
        [joinStackView,
         passwordDescription,
         joinStackView2].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - UI Constraints config
    private func setupConstraints() {
        joinLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Metric.JoinTitle.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Metric.JoinTitle.leading)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(joinLabel.snp.bottom).offset(Metric.ScrollView.top)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(joinButton.snp.top).offset(Metric.ScrollView.bottom)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(Metric.ScrollView.contentViewHeight)
        }
        
        joinStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Metric.StackView.top)
            $0.leading.equalToSuperview().offset(Metric.StackView.leading)
            $0.trailing.equalToSuperview().offset(Metric.StackView.trailing)
        }
        
        passwordDescription.snp.makeConstraints {
            $0.top.equalTo(joinStackView.snp.bottom).offset(Metric.PasswordDescription.top)
            $0.leading.equalTo(joinStackView.snp.leading)
        }
        
        joinStackView2.snp.makeConstraints {
            $0.top.equalTo(passwordDescription.snp.bottom).offset(Metric.StackView2.top)
            $0.leading.equalTo(passwordDescription.snp.leading)
            $0.trailing.equalTo(joinStackView.snp.trailing)
        }
                
        joinButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(Metric.JoinButton.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.JoinButton.sideInset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.JoinButton.sideInset)
            $0.height.equalTo(Metric.JoinButton.height)
        }
    }
}

