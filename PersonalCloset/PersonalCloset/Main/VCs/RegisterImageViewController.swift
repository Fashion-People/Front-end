//
//  RegisterImageViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 12/30/23.
//

import UIKit
import SnapKit

protocol RegisterImageViewControllerDelegate : AnyObject {
    func presentResultVC()
    func backToPreviousVC()
}

final class RegisterImageViewController : BaseViewController {
    weak var delegate : RegisterImageViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.selectButton.isHidden = true
        tabTopViewButtons()
        buttonConfiguration()
    }
    
    private let imageInputStackView1 : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 15
        
        return stackView
    }()
    
    private let imageInputStackView2 : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 15
        
        return stackView
    }()
    
    private var imageInput1 = ImageInputButton()
    private var imageInput2 = ImageInputButton()
    private var imageInput3 = ImageInputButton()
    private var imageInput4 = ImageInputButton()
    
    private lazy var registerButton = PersonalClosetButton("적합도를 알려주세요!",
                                                           titleColor: .darkBlue,
                                                           backColor: .skyBlue,
                                                           action: UIAction { _ in
        self.uploadImage()
        self.delegate.presentResultVC()
    })
    private func buttonConfiguration() {
        imageInput1.tag = 1
        imageInput2.tag = 2
        imageInput3.tag = 3
        imageInput4.tag = 4
        
        imageInput1.inputImageButton.addAction(UIAction { _ in
            self.tabImageButton(tag: 1)
        }, for: .touchUpInside)
        
        imageInput2.inputImageButton.addAction(UIAction { _ in
            self.tabImageButton(tag: 2)
        }, for: .touchUpInside)
        
        imageInput3.inputImageButton.addAction(UIAction { _ in
            self.tabImageButton(tag: 3)
        }, for: .touchUpInside)
        
        imageInput4.inputImageButton.addAction(UIAction { _ in
            self.tabImageButton(tag: 4)
        }, for: .touchUpInside)
    }
    
    private func uploadImage() {
        let S3 = S3Upload()
        var count = 0
        
        if (self.imageInput1.inputImageButton.imageView?.image != nil) {
            S3.uploadImageFile(imgData:self.imageInput1.inputImageButton.currentImage)
        } else {
            print("이미지 없음")
            count += 1
        }
        
        if (self.imageInput2.inputImageButton.imageView?.image != nil) {
            S3.uploadImageFile(imgData:self.imageInput2.inputImageButton.currentImage)
        } else {
            print("이미지2 없음")
            count += 1
        }
        
        if (self.imageInput3.inputImageButton.imageView?.image != nil) {
            S3.uploadImageFile(imgData:self.imageInput3.inputImageButton.currentImage)
        } else { print("이미지3 없음")
            count += 1
        }
        
        if (self.imageInput4.inputImageButton.imageView?.image != nil) {
            S3.uploadImageFile(imgData:self.imageInput4.inputImageButton.currentImage)
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

    private func tabTopViewButtons(){
        topView.backButton.addAction(UIAction{ _ in
            self.delegate.backToPreviousVC()
        }, for: .touchUpInside)
    }
    
    // MARK: - setupLayout
    override func setLayout() {
        super.setLayout()
        
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
        
        imageInputStackView1.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
        
        imageInputStackView2.snp.makeConstraints {
            $0.top.equalTo(imageInputStackView1.snp.bottom).offset(15)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(imageInputStackView2.snp.bottom).offset(40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(230)
            $0.height.equalTo(50)
        }
    }
}

// MARK: - extension
extension RegisterImageViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false) { () in
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            
            if let tag = picker.view?.tag {
                switch tag {
                case 1:
                    self.imageInput1.inputImageButton.setImage(image, for: .normal)
                case 2:
                    self.imageInput2.inputImageButton.setImage(image, for: .normal)
                case 3:
                    self.imageInput3.inputImageButton.setImage(image, for: .normal)
                case 4:
                    self.imageInput4.inputImageButton.setImage(image, for: .normal)
                default:
                    break
                }
            }
        }
    }
}


