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
    
    private enum Metric {
        enum InputImageView {
            static let inputImageSpacing: CGFloat = 15
            static let sideInset: CGFloat = 30
        }
        
        enum RegisterButton {
            static let heigth: CGFloat = 50
            static let width: CGFloat = 230
            static let top: CGFloat = 40
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    private lazy var registerButton = PersonalClosetButton("적합도를 알려주세요!",
                                                           titleColor: .darkBlue,
                                                           backColor: .skyBlue,
                                                           action: UIAction { _ in
        
        Task {
            do {
                
                try await self.uploadImage()
                
                Thread.sleep(forTimeInterval: 3)

                let params = FitnessTestRequestDTO (
                    imageUrl: ImageTempManager.shared.imageURLs,
                    latitude: LocationManager.shared.location.latitude,
                    longtitude: LocationManager.shared.location.longtitude,
                    situation: "회사"
                )
                
                print(ImageTempManager.shared.imageURLs)
                
                /// 이미지 업로드가 성공적으로 완료되면 FitnessTestAPI 호출
                try await FitnessTestAPI.fitnessTest.performRequest(with: params)
            } catch {
                print("Error: \(error)")
            }
        }
        
        self.delegate.presentResultVC()
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
            print("이미지 없음")
            count += 1
        }
        
        if (self.imageInput2.imageView?.image != nil) {
            S3.uploadImageFile(imgData:self.imageInput2.currentImage)
        } else {
            print("이미지2 없음")
            count += 1
        }
        
        if (self.imageInput3.imageView?.image != nil) {
            S3.uploadImageFile(imgData:self.imageInput3.currentImage)
        } else { print("이미지3 없음")
            count += 1
        }
        
        if (self.imageInput4.imageView?.image != nil) {
            S3.uploadImageFile(imgData:self.imageInput4.currentImage)
        } else { print("이미지4 없음")
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

    private func tabTopViewButtons() {
        topView.backButton.addAction(UIAction{ _ in
            self.delegate.backToPreviousVC()
        }, for: .touchUpInside)
    }
    
    // MARK: - setupLayout
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
         registerButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - UI Constraints config
    override func setupConstraints() {
        super.setupConstraints()
        
        imageInputStackView1.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(Metric.InputImageView.inputImageSpacing)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.InputImageView.sideInset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.InputImageView.sideInset)
        }
        
        imageInputStackView2.snp.makeConstraints {
            $0.top.equalTo(imageInputStackView1.snp.bottom).offset(Metric.InputImageView.inputImageSpacing)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.InputImageView.sideInset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.InputImageView.sideInset)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(imageInputStackView2.snp.bottom).offset(Metric.RegisterButton.top)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(Metric.RegisterButton.width)
            $0.height.equalTo(Metric.RegisterButton.heigth)
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


