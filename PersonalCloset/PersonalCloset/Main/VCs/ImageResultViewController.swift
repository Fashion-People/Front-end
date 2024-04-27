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
    
    private enum Metric {
        static let width: CGFloat = 300

        enum Buttons {
            static let bottom: CGFloat = -30
            static let height: CGFloat = 50
        }
        
        enum ResultImage {
            static let height: CGFloat = 300
            static let top: CGFloat = 20
        }
        
        enum ResultLabel {
            static let top: CGFloat = 40
        }
    }
    
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
    override func setupLayouts() {
        super.setupLayouts()
        
        [resultImageView,
         resultLabel,
         addClothListButton,
         backToRegisterButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - UI Constraints config
    override func setupConstraints() {
        super.setupConstraints()
        
        resultImageView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(Metric.ResultImage.top)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Metric.ResultImage.height)
            $0.width.equalTo(Metric.width)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(resultImageView.snp.bottom).offset(Metric.ResultLabel.top)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(Metric.width)
        }
        
        addClothListButton.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(backToRegisterButton.snp.top).offset(Metric.Buttons.bottom)
            $0.width.equalTo(Metric.width)
            $0.height.equalTo(Metric.Buttons.height)
        }
        
        backToRegisterButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(Metric.Buttons.bottom)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(Metric.width)
            $0.height.equalTo(Metric.Buttons.height)
        }
    }
}
