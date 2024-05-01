//
//  RegisterImageViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 12/30/23.
//

import UIKit
import SnapKit

protocol RegisterImageViewControllerDelegate: AnyObject {
    func presentResultVC()
    func backToPreviousVC()
}

final class RegisterImageViewController: BaseViewController {
    weak var delegate: RegisterImageViewControllerDelegate!
    private let situations: [String] = ["회사", "데이트", "결혼식", "운동", "학교", "도서관", "나들이"]
    private var situationTitle: String = "회사"
    
    // MARK: - Metric
    private enum Metric {
        enum InputImageView {
            static let inputImageSpacing: CGFloat = 10
            static let sideInset: CGFloat = 30
        }
        
        enum RegisterButton {
            static let height: CGFloat = 50
            static let width: CGFloat = 300
            static let top: CGFloat = 40
            static let bottom: CGFloat = -20
        }
        
        enum SituationDescription {
            static let top: CGFloat = 20
        }
        
        enum SituationPickerView {
            static let top: CGFloat = 20
            static let sideInset: CGFloat = 60
            static let height: CGFloat = 100
            static let bottom: CGFloat = -50
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(self.indicatorView)

        self.topView.selectButton.isHidden = true
        self.tabTopViewButtons()
        self.buttonConfiguration()
    }
    
    private let imageInputStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = Metric.InputImageView.inputImageSpacing
        
        return stackView
    }()
    
    private let imageInputStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = Metric.InputImageView.inputImageSpacing
        
        return stackView
    }()
    
    private lazy var imageInput1 = ImageInputButton()
    private lazy var imageInput2 = ImageInputButton()
    private lazy var imageInput3 = ImageInputButton()
    private lazy var imageInput4 = ImageInputButton()
    
    private lazy var situationDescription: UILabel = {
        let label = UILabel()
        label.text = "외출 상황을 선택해주세요!"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    private lazy var situationPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        return pickerView
    }()
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = self.view.center
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        
//        activityIndicator.stopAnimating()
        
        return activityIndicator
        
    }()

    private lazy var registerButton = PersonalClosetButton("적합도를 알려주세요!",
                                                           titleColor: .darkBlue,
                                                           backColor: .skyBlue,
                                                           action: UIAction { _ in
        
        Task {
            do {
                try await self.uploadImage()
                
                Thread.sleep(forTimeInterval: 8)

                let params = FitnessTestRequestDTO (
                    imageUrl: ImageTempManager.shared.imageURLs,
                    situation: self.situationTitle
                )
                
                print(ImageTempManager.shared.imageURLs)
                
                try await FitnessTestAPI.fitnessTest.performRequest(with: params)
                
                if !ImageTempManager.shared.imageURLs.isEmpty {
                    /// 이미지 업로드가 성공적으로 완료되면 FitnessTestAPI 호출
                    self.delegate.presentResultVC()
                }
            } catch {
                print("Error: \(error)")
            }
        }
    })
    
    private func buttonConfiguration() {
        imageInput1.tag = 1
        imageInput2.tag = 2
        imageInput3.tag = 3
        imageInput4.tag = 4
        
        imageInput1.addAction(UIAction { _ in
            self.tabImageButton(tag: 1)
        }, for: .touchUpInside)
        
        imageInput2.addAction(UIAction { _ in
            self.tabImageButton(tag: 2)
        }, for: .touchUpInside)
        
        imageInput3.addAction(UIAction { _ in
            self.tabImageButton(tag: 3)
        }, for: .touchUpInside)
        
        imageInput4.addAction(UIAction { _ in
            self.tabImageButton(tag: 4)
        }, for: .touchUpInside)
    }

    private func uploadImage() async throws {
        let S3 = S3Upload()
        var count = 0
        
        if (self.imageInput1.imageView?.image != nil) {
            S3.uploadImageFile(imgData:self.imageInput1.currentImage)
        } else {
            count += 1
        }
        
        if (self.imageInput2.imageView?.image != nil) {
            S3.uploadImageFile(imgData:self.imageInput2.currentImage)
        } else {
            count += 1
        }
        
        if (self.imageInput3.imageView?.image != nil) {
            S3.uploadImageFile(imgData:self.imageInput3.currentImage)
        } else {
            count += 1
        }
        
        if (self.imageInput4.imageView?.image != nil) {
            S3.uploadImageFile(imgData:self.imageInput4.currentImage)
        } else { 
            count += 1
        }
        
        if (count == 4) {
            let imageNilAlert = UIAlertController(title: "알림",
                                                 message: "하나 이상의 이미지를 등록해주세요",
                                                 preferredStyle: UIAlertController.Style.alert)
            
            let success = UIAlertAction(title: "확인", style: .default)
            imageNilAlert.addAction(success)
            self.present(imageNilAlert, animated: true, completion: nil)
        }
        
    }
    
    private func tabImageButton(tag: Int) {
        let imagePicker = UIImagePickerController()

        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true

        imagePicker.view.tag = tag

        self.present(imagePicker, animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        situationTitle = situations[row]
    }

    private func tabTopViewButtons() {
        topView.backButton.addAction(UIAction{ _ in
            self.delegate.backToPreviousVC()
        }, for: .touchUpInside)
    }
    
    // MARK: - UI Hierarchy config
    override func setupLayouts() {
        super.setupLayouts()
        
        [imageInput1,imageInput2].forEach {
            imageInputStackView1.addArrangedSubview($0)
        }
        
        [imageInput3,imageInput4].forEach {
            imageInputStackView2.addArrangedSubview($0)
        }
        
        [imageInputStackView1,
         imageInputStackView2,
         situationDescription,
         situationPickerView,
         registerButton,
         indicatorView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - UI Constraints config
    override func setupConstraints() {
        super.setupConstraints()
            
        imageInputStackView1.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(Metric.InputImageView.inputImageSpacing)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(170)
            
        }
        
        imageInputStackView2.snp.makeConstraints {
            $0.top.equalTo(imageInputStackView1.snp.bottom).offset(Metric.InputImageView.inputImageSpacing)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(170)
        }
        
        situationDescription.snp.makeConstraints {
            $0.top.equalTo(imageInputStackView2.snp.bottom).offset(Metric.SituationDescription.top)
            $0.centerX.equalTo(imageInputStackView2.snp.centerX)
        }
        
        situationPickerView.snp.makeConstraints {
            $0.top.equalTo(situationDescription.snp.bottom)
            $0.centerX.equalTo(situationDescription.snp.centerX)
            $0.bottom.equalTo(registerButton.snp.top).offset(Metric.SituationPickerView.bottom)
            $0.height.equalTo(Metric.SituationPickerView.height)
        }
        
        registerButton.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(imageInputStackView2.snp.width)
            $0.height.equalTo(Metric.RegisterButton.height)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(Metric.RegisterButton.bottom)
        }
    }
}

// MARK: - extension
extension RegisterImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false) { () in
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            
            if let tag = picker.view?.tag {
                switch tag {
                case 1:
                    self.imageInput1.setImage(image, for: .normal)
                case 2:
                    self.imageInput2.setImage(image, for: .normal)
                case 3:
                    self.imageInput3.setImage(image, for: .normal)
                case 4:
                    self.imageInput4.setImage(image, for: .normal)
                default:
                    break
                }
            }
        }
    }
}


extension RegisterImageViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return situations.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.systemFont(ofSize: 10, weight: .bold)
        ]
        
        return NSAttributedString(string: situations[row], attributes: attributes)
    }
}

extension RegisterImageViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return situations[row]
    }
}
