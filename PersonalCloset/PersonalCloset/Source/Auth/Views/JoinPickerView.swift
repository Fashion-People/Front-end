//
//  JoinPickerView.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/9/24.
//

import UIKit

final class JoinPickerView: UIView {
    private enum Metric {
        enum InputLabel {
            static let height: CGFloat = 50
        }
        
        enum PickerView {
            static let width: CGFloat = 340
            static let height: CGFloat = 70
        }
    }
    
    var style: String = "모던"
    private var styles: [String] = ["모던", "캐주얼", "스포티", "페미닌"]
    
    private let pickerTitle: String
    
    private let inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private var inputLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        return label
    }()
    
    private var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.layer.cornerRadius = 5
        pickerView.layer.backgroundColor = UIColor.skyBlue.cgColor

        return pickerView
    }()
    
    init(_ pickerTitle: String) {
        self.pickerTitle = pickerTitle
        super.init(frame: .zero)
        
        self.setupLayout()
        self.setupStyles()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyles() {
        inputLabel.text = pickerTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        style = styles[row]
    }

    
    private func setupLayout() {
        [inputLabel,
         pickerView].forEach {
            inputStackView.addArrangedSubview($0)
        }
        
        inputLabel.snp.makeConstraints {
            $0.height.equalTo(Metric.InputLabel.height)
        }
        
        pickerView.snp.makeConstraints {
            $0.width.equalTo(Metric.PickerView.width)
            $0.height.equalTo(Metric.PickerView.height)
        }
        
        addSubview(inputStackView)
        
        inputStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - pickerView extension
extension JoinPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, 
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return styles[row]
    }
}

extension JoinPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return styles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, 
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.systemFont(ofSize: 10, weight: .bold)
        ]
        
        return NSAttributedString(string: styles[row], attributes: attributes)
    }
}
