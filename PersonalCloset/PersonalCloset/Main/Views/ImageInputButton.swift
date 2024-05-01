//
//  ImageInputButton.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit

final class ImageInputButton: UIButton {
    private enum Metric {
        static let height: CGFloat = 170
        static let width: CGFloat = 170
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
        self.setupStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI Constraints config
    private func setupConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(Metric.height)
            $0.width.equalTo(Metric.width)
        }
    }
    
    private func setupStyles() {
        self.backgroundColor = .lightGray
        self.tintColor = .black
        self.layer.cornerRadius = 5
    }
}
