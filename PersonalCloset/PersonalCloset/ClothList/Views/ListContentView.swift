//
//  ListContentView.swift
//  PersonalCloset
//
//  Created by Bowon Han on 2/29/24.
//

import UIKit
import SnapKit

final class ListContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
       didSet {
           apply(configuration as! ContentConfiguration)
       }
    }
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        self.setupLayouts()
        apply(configuration as! ContentConfiguration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var clothImageView = UIImageView()
    private lazy var imageTitleLabel = UILabel()
    
    private lazy var menuItems: [UIAction] = {
        return [UIAction(title: "삭제",
                         image: UIImage(systemName: "trash"),
                         handler: { _ in print("삭제버튼")}),
                UIAction(title: "수정",
                         image: UIImage(systemName: "pencil"),
                         handler: { _ in print("수정버튼")})
                ]
    }()
    
    private lazy var menu: UIMenu = { return UIMenu(title: "", options: [], children: menuItems) }()
                         
    private lazy var imageSettingButton: UIButton = {
        let button = UIButton()
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        
        return button
    }()
        
    private func setupLayouts() {
        [clothImageView,
         imageTitleLabel,
         imageSettingButton].forEach {
            addSubview($0)
        }

        clothImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(80)
        }

        imageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(clothImageView.snp.top).offset(5)
            $0.leading.equalTo(clothImageView.snp.trailing).offset(20)
            $0.height.equalTo(20)
        }

        imageSettingButton.snp.makeConstraints {
            $0.centerY.equalTo(clothImageView.snp.centerY)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
    }
    
    private func apply(_ configuration: ContentConfiguration) {
        imageTitleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        clothImageView.tintColor = .lightGray
        clothImageView.image = UIImage(named: "exampleImage")
        
        imageSettingButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        imageSettingButton.tintColor = .lightGray
        
        imageTitleLabel.text = configuration.clothDescription
    }
}
