//
//  BaseViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

class BaseViewController : UIViewController {
    // MARK: - Property
    private(set) var didSetupConstraints = false
    
    // MARK: - Initializing
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setLayout()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    // MARK: - Top View
    lazy var topView : TopView = {
        let view = TopView()
        
        return view
    }()
    
    func setLayout() {
        view.addSubview(topView)
        
        topView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.height.equalTo(60)
        }
    }
}
