//
//  BaseViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

class BaseViewController : UIViewController {
//    // MARK: - Property
    private(set) var didSetupConstraints = false
    
    private enum Metric {
        static let top: CGFloat = 10
        static let trailing: CGFloat = -10
        static let height: CGFloat = 80
    }
    
//    // MARK: - Initializing
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupLayouts()
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }

    // MARK: - Top View
    lazy var topView = TopView()
    
    func setupLayouts() {
        view.addSubview(topView)
    }
    
    func setupConstraints() {
        topView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Metric.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(Metric.trailing)
            $0.height.equalTo(Metric.height)
        }
    }
}
