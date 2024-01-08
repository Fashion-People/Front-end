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
    var style : [String] = ["모던", "캐주얼", "스포티","페미닌"]
    var first = ""
    var second = ""
    var third = ""
    var fourth = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.hideKeyboardWhenTappedAround()
        inputViewConfig()
        setLayout()
        navigationBarConfig()
                
        firstPickerView.delegate = self
        firstPickerView.dataSource = self
    }
    
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
    
    private let pickerViewLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.text = "취향"
        
        return label
    }()
    
    private var firstPickerView : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.layer.cornerRadius = 5
        pickerView.layer.backgroundColor = UIColor.skyBlue.cgColor
        
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
            self.delegate?.backToLogin()
        }
        joinSuccessAlert.addAction(success)
        self.present(joinSuccessAlert, animated: true, completion: nil)
    }
    
    @objc private func tabJoinButtonbutton() {
        self.delegate?.backToLogin()
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
         pickerViewLabel,
         firstPickerView].forEach {
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
            $0.height.equalTo(700)
        }
        
        joinStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.bottom.equalTo(pickerViewLabel.snp.top).offset(-20)
        }
        
        pickerViewLabel.snp.makeConstraints {
            $0.top.equalTo(joinStackView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.bottom.equalTo(firstPickerView.snp.top).offset(-10)
        }
        
        firstPickerView.snp.makeConstraints {
            $0.top.equalTo(pickerViewLabel.snp.bottom).offset(20)
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

// MARK: - pickerView extension
extension JoinViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return style[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            first = style[row]
            print(first)
        case 1:
            second = style[row]
            print(second)
        case 2:
            third = style[row]
            print(third)
        case 3:
            fourth = style[row]
            print(fourth)
        default:
            print("없음")
        }
    }
}

extension JoinViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
}
