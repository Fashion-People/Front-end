//
//  InputView.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/3/24.
//

import UIKit
import SnapKit

final class InputView: UITextField {
    private let customPlaceholder: String
    
    private enum Metric {
        static let height: CGFloat = 40
    }
    
    init(_ placeholder: String) {
        self.customPlaceholder = placeholder
        super.init(frame: .zero)
        self.setupStyles()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyles() {
        self.borderStyle = .roundedRect
        self.placeholder = customPlaceholder
    }
    
    private func setupConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(Metric.height)
        }
    }
}

