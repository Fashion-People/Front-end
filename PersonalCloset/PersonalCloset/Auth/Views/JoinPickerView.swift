//
//  JoinPickerView.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/9/24.
//

import UIKit

final class JoinPickerView : UIView {
    var style : [String] = ["모던", "캐주얼", "스포티","페미닌"]
    var first = ""
    var second = ""
    var third = ""
    var fourth = ""
    
    private let pickerTitle: String
    
    private let inputStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        
        return stackView
    }()
    
    var inputLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        return label
    }()
    
    var pickerView : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.layer.cornerRadius = 5
        pickerView.layer.backgroundColor = UIColor.skyBlue.cgColor

        return pickerView
    }()
    
    init(_ pickerTitle: String) {
        self.pickerTitle = pickerTitle
        super.init(frame: .zero)
        self.setLayout()
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

    
    private func setLayout() {
        [inputLabel,
         pickerView].forEach {
            inputStackView.addArrangedSubview($0)
        }
        
        inputLabel.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        pickerView.snp.makeConstraints {
            $0.width.equalTo(340)
            $0.height.equalTo(70)
        }
        
        addSubview(inputStackView)
        
        inputStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - pickerView extension
extension JoinPickerView : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return style[row]
    }
}

extension JoinPickerView : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.systemFont(ofSize: 10, weight: .bold)
        ]
        
        return NSAttributedString(string: style[row], attributes: attributes)
    }
}
