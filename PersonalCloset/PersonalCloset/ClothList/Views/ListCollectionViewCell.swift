//
//  ListCollectionViewCell.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/17/24.
//

import UIKit
import SnapKit

final class ListCollectionViewCell : UICollectionViewListCell {
    private var clothImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .darkBlue
        imageView.image = UIImage(systemName: "hanger")
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        
        return imageView
    }()
    
    private var imageTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "예쁜 옷"
        
        return label
    }()
        
    private lazy var imageSettingButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setLayout(){
        [clothImageView,
         imageTitleLabel,
         imageSettingButton].forEach {
            addSubview($0)
        }
        
        clothImageView.snp.makeConstraints {
            $0.leading.equalTo(self).offset(30)
            $0.centerY.equalTo(self)
            $0.height.equalTo(60)
            $0.width.equalTo(60)
        }
        
        imageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(clothImageView.snp.top).offset(5)
            $0.leading.equalTo(clothImageView.snp.trailing).offset(20)
            $0.width.equalTo(200)
        }
        
        imageSettingButton.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.trailing.equalTo(self).offset(-30)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
//        imageSettingButton.snp.makeConstraints {
//            $0.leading.equalTo(self).offset(10)
//            $0.centerY.equalTo(self)
//            $0.height.equalTo(30)
//            $0.width.equalTo(30)
//        }
//        
//        imageTitleLabel.snp.makeConstraints {
//            $0.top.equalTo(clothImageView.snp.top).offset(5)
//            $0.leading.equalTo(clothImageView.snp.trailing).offset(20)
//            $0.width.equalTo(200)
//        }
//        
//        clothImageView.snp.makeConstraints {
//            $0.leading.equalTo(imageSettingButton.snp.trailing).offset(15)
//            $0.centerY.equalTo(self)
//            $0.height.equalTo(60)
//            $0.width.equalTo(60)
//        }
    }
}


