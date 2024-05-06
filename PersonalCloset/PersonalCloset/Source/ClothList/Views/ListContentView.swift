//
//  ListContentView.swift
//  PersonalCloset
//
//  Created by Bowon Han on 2/29/24.
//

import UIKit
import SnapKit

final class ListContentView: UIView, UIContentView {
    var deleteAction: (()->())
    var modifyAction: (()->())
    
    var configuration: UIContentConfiguration {
       didSet {
           apply(configuration as! ListContentConfiguration)
       }
    }
    
    init(configuration: UIContentConfiguration, deleteAction: @escaping (()->()), modifyAction: @escaping (()->())) {
        self.configuration = configuration
        self.deleteAction = deleteAction
        self.modifyAction = modifyAction
        super.init(frame: .zero)
        self.setupLayouts()
        self.setupConstraints()
        apply(configuration as! ListContentConfiguration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var clothImageView = UIImageView()
    private lazy var imageTitleLabel = UILabel()
    
    private lazy var menuItems: [UIAction] = {
        return [UIAction(title: "삭제",
                         image: UIImage(systemName: "trash"),
                         handler: { _ in
            self.deleteAction()
        }),
                UIAction(title: "수정",
                         image: UIImage(systemName: "pencil"),
                         handler: { _ in
            self.modifyAction()
        })
        ]
    }()
    
    private lazy var menu: UIMenu = { return UIMenu(title: "", options: [], children: menuItems) }()
                         
    private lazy var imageSettingButton: UIButton = {
        let button = UIButton()
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        
        return button
    }()
    
    private func loadImage(data: String) {
        guard let url = URL(string: data)  else { return }
        
        let backgroundQueue = DispatchQueue(label: "background_queue",qos: .background)
        
        backgroundQueue.async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.clothImageView.image = UIImage(data: data)
            }
        }
    }
       
    /// set configuration
    private func apply(_ configuration: ListContentConfiguration) {
        imageTitleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        clothImageView.tintColor = .lightGray
        
        imageSettingButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        imageSettingButton.tintColor = .lightGray
        
        loadImage(data: configuration.imageUrl ?? "")
        imageTitleLabel.text = configuration.clothDescription
    }
        
    // MARK: - UI Layouts config
    private func setupLayouts() {
        [clothImageView,
         imageTitleLabel,
         imageSettingButton].forEach {
            addSubview($0)
        }
    }
        
    // MARK: - UI Constraints config
    private func setupConstraints() {
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
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
    }
}
