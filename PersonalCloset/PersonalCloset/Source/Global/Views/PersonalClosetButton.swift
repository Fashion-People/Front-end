//
//  PersonalClosetButton.swift
//  PersonalCloset
//
//  Created by Bowon Han on 2/27/24.
//

import UIKit

final class PersonalClosetButton: UIButton {
    private let buttonSetTitle: String
    private let buttonTitleColor: UIColor
    private let buttonBackgroundColor: UIColor
    private var tabButtonAction: UIAction

    init(_ buttonTitle: String, titleColor: UIColor, backColor: UIColor, action: UIAction) {
        self.buttonSetTitle = buttonTitle
        self.buttonTitleColor = titleColor
        self.buttonBackgroundColor = backColor
        self.tabButtonAction = action
        super.init(frame: .zero)
        self.setupStyles()
        self.addAction(tabButtonAction, for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setup Styles
    private func setupStyles() {
        self.setTitle(buttonSetTitle, for: .normal)
        self.setTitleColor(buttonTitleColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
        self.layer.borderColor = buttonBackgroundColor.cgColor
        self.layer.backgroundColor = buttonBackgroundColor.cgColor
    }
}
