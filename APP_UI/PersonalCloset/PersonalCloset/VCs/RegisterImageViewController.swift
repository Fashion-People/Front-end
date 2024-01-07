//
//  RegisterImageViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 12/30/23.
//

import UIKit
import SnapKit

class RegisterImageViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
                
//        let topView = TopView()
//        navigationItem.titleView = topView
    }
    
    private let imageInputStackView1 : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 15
        
        return stackView
    }()
    
    private let imageInputStackView2 : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 15
        
        return stackView
    }()
    
    private var imageInput1 = ImageInputButton()
    private var imageInput2 = ImageInputButton()
    private var imageInput3 = ImageInputButton()
    private var imageInput4 = ImageInputButton()
    
    private lazy var registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("적합도를 알려주세요!", for: .normal)
        button.setTitleColor(.darkBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.skyBlue.cgColor
        button.layer.backgroundColor = UIColor.skyBlue.cgColor
        button.addAction(
            UIAction { _ in
//                let resultImageVC = ImageResultViewController()
//                resultImageVC.modalPresentationStyle = .fullScreen
//                resultImageVC.modalTransitionStyle = .crossDissolve
//                self.present(resultImageVC, animated: true, completion: nil)
//                self.navigationController?.pushViewController(ImageResultViewController(),
//                                                              animated: true)
            },
            for: .touchUpInside
        )
        
        return button
    }()
    
    override func setLayout() {
        super.setLayout()
        
        [imageInput1,imageInput2].forEach {
            imageInputStackView1.addArrangedSubview($0)
        }
        
        [imageInput3,imageInput4].forEach {
            imageInputStackView2.addArrangedSubview($0)
        }
        
        [imageInputStackView1,
         imageInputStackView2,
         registerButton].forEach {
            view.addSubview($0)
        }
        
        imageInputStackView1.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(40)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
        
        imageInputStackView2.snp.makeConstraints {
            $0.top.equalTo(imageInputStackView1.snp.bottom).offset(15)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(imageInputStackView2.snp.bottom).offset(40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(230)
            $0.height.equalTo(60)
        }
    }
}