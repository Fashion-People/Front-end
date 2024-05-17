//
//  SettingTableViewCell.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//


import UIKit
import SnapKit

final class SettingTableViewCell: UITableViewCell {
    var settingTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayouts()
        self.setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - UI Layouts config
    private func setupLayouts() {
        contentView.addSubview(settingTitleLabel)
    }
    
    // MARK: - UI Constraints config
    private func setupConstraints() {
        settingTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().offset(-15)
//            $0.trailing.equalToSuperview().offset(-15)
        }
    }
}
