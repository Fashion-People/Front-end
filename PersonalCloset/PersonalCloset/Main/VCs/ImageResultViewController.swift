//
//  ImageResultViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/3/24.
//

import UIKit
import SnapKit

protocol ImageResultNavigation : AnyObject {
    func backToRegisterVC()
    func backToPreviousVC()
}

final class ImageResultViewController : BaseViewController {
    weak var coordinator : ImageResultNavigation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topViewConfig()
        topView.selectButton.isHidden = true
    }
    
    init(coordinator: ImageResultNavigation) {
        self.coordinator = coordinator
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private lazy var backToRegisterButton = PersonalClosetButton("다시 검사하기",
                                                            titleColor: .darkBlue,
                                                             backColor: .skyBlue,
                                                             action: UIAction { _ in
                                                                        self.coordinator?.backToRegisterVC()
                                                                    })
    
    // MARK: - button click method
    private func topViewConfig() {
        topView.backButton.addAction(UIAction{ _ in
            self.coordinator?.backToRegisterVC()
        }, for: .touchUpInside)
    }
    
    // MARK: - setup Layout
    override func setLayout() {
        super.setLayout()
        
        [resultImageView,
         resultLabel,
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
        
        backToRegisterButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(230)
            $0.height.equalTo(50)       
        }
    }
}
