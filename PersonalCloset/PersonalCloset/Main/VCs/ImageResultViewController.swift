//
//  ImageResultViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/3/24.
//

import UIKit
import SnapKit

protocol ImageResultViewControllerDelegate : AnyObject {
    func backToRegisterVC()
    func backToPreviousVC()
}

final class ImageResultViewController : BaseViewController {
    weak var delegate : ImageResultViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topViewConfig()
        topView.selectButton.isHidden = true
    }
    
    private var resultImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkBlue
        
        return imageView
    }()
    
    private var resultLabel : UILabel = {
        let label = UILabel()
        label.text = "적합도는 79% 입니다."
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var addClothListButton = PersonalClosetButton("리스트에 추가", 
                                                            titleColor: .darkBlue,
                                                            backColor: .bwGray,
                                                            action: UIAction { _ in
                                                                self.delegate?.backToPreviousVC()
                                                                })
    
    private lazy var backToRegisterButton = PersonalClosetButton("다시 검사하기",
                                                            titleColor: .darkBlue,
                                                             backColor: .skyBlue,
                                                             action: UIAction { _ in
                                                                        self.delegate?.backToRegisterVC()
                                                                    })
    
    // MARK: - button click method
    private func topViewConfig() {
        topView.backButton.addAction(UIAction{ _ in
            self.delegate?.backToRegisterVC()
        }, for: .touchUpInside)
    }
    
    // MARK: - setup Layout
    override func setLayout() {
        super.setLayout()
        
        [resultImageView,
         resultLabel,
         addClothListButton,
         backToRegisterButton].forEach {
            view.addSubview($0)
        }
        
        resultImageView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(20)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(300)
            $0.width.equalTo(300)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(resultImageView.snp.bottom).offset(40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(300)
        }
        
        addClothListButton.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(backToRegisterButton.snp.top).offset(-20)
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
        
        backToRegisterButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
    }
}
