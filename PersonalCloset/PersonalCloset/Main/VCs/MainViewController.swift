//
//  MainViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 12/30/23.
//

import UIKit
import SnapKit
import CoreLocation

protocol MainViewControllerDelegate: AnyObject {
    func presentMainVC()
    func presentRegisterVC()
}

final class MainViewController: BaseViewController {
    weak var delegate: MainViewControllerDelegate?
    
    private enum Metric {
        enum cameraButton {
            static let top: CGFloat = 20
            static let height: CGFloat = 200
            static let sideInset: CGFloat = 30
        }
        
        enum emptyView {
            static let top: CGFloat = 30
            static let inset: CGFloat = 30
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topView.backButton.isHidden = true
        self.topView.selectButton.isHidden = true
    }
    
    // MARK: - UI config
    private lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .darkBlue
        button.layer.cornerRadius = 10
        button.backgroundColor = .skyBlue
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .light)
        let image = UIImage(systemName: "camera.fill", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        
        button.addAction(UIAction { _ in
            self.tabCameraButton()
            }, for: .touchUpInside
        )

        return button
    }()
    
    private let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .skyBlue
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    // MARK: - method
    private func tabCameraButton() {
        /// 카메라 버튼 눌렀을때
        delegate?.presentRegisterVC()
    }
    
    // MARK: - UI layout config
    override func setupLayouts() {
        super.setupLayouts()
        
        [cameraButton, 
         emptyView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - UI Constraints config
    override func setupConstraints() {
        super.setupConstraints()
        
        cameraButton.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(Metric.cameraButton.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.cameraButton.sideInset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.cameraButton.sideInset)
            $0.height.equalTo(Metric.cameraButton.height)
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(cameraButton.snp.bottom).offset(Metric.emptyView.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.emptyView.inset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.emptyView.inset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Metric.emptyView.inset)
        }
    }
}
