//
//  AddImageViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 5/9/24.
//

import UIKit
import SnapKit

protocol AddImageViewControllerDelegate: AnyObject {
    func backToPreviousVC()
}

final class AddImageViewController: BaseViewController {
    weak var delegate: AddImageViewControllerDelegate?
    
    private enum Metric {
        enum AddImageButton {
            static let top: CGFloat = 20
            static let inset: CGFloat = 20
            static let height: CGFloat = 400
        }
        
        enum DescriptionTextView {
            static let top: CGFloat = 10
            static let inset: CGFloat = 20
            static let height: CGFloat = 100
        }
        
        enum AddListButton {
            static let bottom: CGFloat = -20
            static let inset: CGFloat = 20
            static let height: CGFloat = 50
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topView.selectButton.isHidden = true
        self.tabTopViewButtons()
    }
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .bwGray
        button.layer.cornerRadius = 5
        button.addAction(UIAction { _ in
            button.tag = 1
            self.tabImageButton(tag: 1)
        }, for: .touchUpInside)
        
        return button
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .bwGray
        textView.text = "옷 설명을 입력하세요"
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.bwGray.cgColor
        textView.layer.cornerRadius = 5
        textView.isScrollEnabled = false
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var addListButton = PersonalClosetButton("이미지 추가", titleColor: .darkBlue, backColor: .skyBlue, action: UIAction { [weak self] _ in
        
        guard let description = self?.descriptionTextView.text else { return }
        
        var params = ClothRequestDTO(description: description, imageUrl: "https://fashionbucket.s3.ap-northeast-2.amazonaws.com/profile/image/옷.jpeg")
        
        Task {
            do {
                try await ClothesAPI.createCloth.performRequest(with: params)
                
                DispatchQueue.main.async {
                    let successAlert = UIAlertController(title: "알림", message: "옷 저장에 성공하였습니다!", preferredStyle: UIAlertController.Style.alert)
                    let check = UIAlertAction(title: "네", style: .default) { action in
                        self?.delegate?.backToPreviousVC()
                    }
                    
                    successAlert.addAction(check)
                    self?.present(successAlert, animated: true, completion: nil)
                }
            } catch {
                print("error: \(error)")
            }
        }
    })
    
    private func tabTopViewButtons() {
        topView.backButton.addAction(UIAction{ [weak self] _ in
            self?.delegate?.backToPreviousVC()
        }, for: .touchUpInside)
    }
    
    private func tabImageButton(tag: Int) {
        let imagePicker = UIImagePickerController()

        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true

        imagePicker.view.tag = tag

        self.present(imagePicker, animated: true)
    }

    // MARK: - set up UI Hierarchy
    override func setupLayouts() {
        super.setupLayouts()
        
        [addImageButton,
         descriptionTextView,
         addListButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - set up UI Constraints
    override func setupConstraints() {
        super.setupConstraints()
        
        addImageButton.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(Metric.AddImageButton.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.AddImageButton.inset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.AddImageButton.inset)
            $0.height.equalTo(Metric.AddImageButton.height)
        }
        
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(addImageButton.snp.bottom).offset(Metric.DescriptionTextView.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.DescriptionTextView.inset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.DescriptionTextView.inset)
            $0.height.equalTo(Metric.DescriptionTextView.height)
        }
        
        addListButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(Metric.AddListButton.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.AddListButton.inset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.AddListButton.inset)
            $0.height.equalTo(Metric.AddListButton.height)
        }
    }
}

extension AddImageViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .bwGray else { return }
        textView.text = nil
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "옷 설명을 입력하세요"
            textView.textColor = .bwGray
        }
    }
}

extension AddImageViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false) { () in
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            
            if let tag = picker.view?.tag {
                switch tag {
                case 1:
                    self.addImageButton.setImage(image, for: .normal)
                default:
                    break
                }
            }
        }
    }
}
