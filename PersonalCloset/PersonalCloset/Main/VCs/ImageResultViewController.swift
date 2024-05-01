//
//  ImageResultViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/3/24.
//

import UIKit
import SnapKit

protocol ImageResultViewControllerDelegate: AnyObject {
    func backToRegisterVC()
    func backToPreviousVC()
}

final class ImageResultViewController: BaseViewController {
    
    weak var delegate: ImageResultViewControllerDelegate?
    private let fitnessTestResult = FitnessTestManager.shared.result
    private var resultImageUrl: String = ""
    
    private enum Metric {
        static let width: CGFloat = 300

        enum Buttons {
            static let bottom: CGFloat = -20
            static let height: CGFloat = 50
            static let width: CGFloat = 350
        }
        
        enum ResultImage {
            static let height: CGFloat = 300
            static let top: CGFloat = 20
        }
        
        enum ResultLabel {
            static let top: CGFloat = 40
            static let width: CGFloat = 250
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultImageUrl = ImageTempManager.shared.imageURLs[self.fitnessTestResult.clothesNumber-1]
        loadImage(data: resultImageUrl)
        self.resultLabel.text = "해당 옷의 적합도 수치가 \(String(self.fitnessTestResult.figure))%로 가장 높습니다."
        self.topViewConfig()
        self.topView.selectButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ImageTempManager.shared.imageURLs.removeAll()
    }
    
    private lazy var resultImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.backgroundColor = .darkBlue
        
        return imageView
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var addClothListButton = PersonalClosetButton("리스트에 추가", 
                                                            titleColor: .darkBlue,
                                                            backColor: .bwGray,
                                                               action: UIAction { _ in
        let descriptionAlert = UIAlertController(title: "설명", message: "옷에 대한 상세정보를 작성해주세요", preferredStyle: UIAlertController.Style.alert)
        descriptionAlert.addTextField()
        
        let success = UIAlertAction(title: "확인", style: .default) { action in
            var params = ClothRequestDTO(description: descriptionAlert.textFields?[0].text ?? "", imageURL: self.resultImageUrl)
            print(params)
            
            Task {
                do {
                    try await ClothesAPI.createCloth.performRequest(with: params)
                } catch {
                    print("error: \(error)")
                }
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            
        }
        
        descriptionAlert.addAction(success)
        descriptionAlert.addAction(cancel)
        
        self.present(descriptionAlert, animated: true, completion: nil)
        self.delegate?.backToPreviousVC()
    })
    
    private lazy var backToRegisterButton = PersonalClosetButton("다시 검사하기",
                                                            titleColor: .darkBlue,
                                                             backColor: .skyBlue,
                                                             action: UIAction { _ in
                                                                        self.delegate?.backToRegisterVC()
                                                                    })
    
    // MARK: - button click method
    private func topViewConfig() {
        topView.backButton.addAction(UIAction{ _ in
            self.delegate?.backToRegisterVC()
        }, for: .touchUpInside)
    }
    
    private func loadImage(data: String) {
        guard let url = URL(string: data)  else { return }
        
        let backgroundQueue = DispatchQueue(label: "background_queue",qos: .background)
        
        backgroundQueue.async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.resultImageView.image = UIImage(data: data)
            }
        }
    }
    
    // MARK: - setup Layout
    override func setupLayouts() {
        super.setupLayouts()
        
        [resultImageView,
         resultLabel,
         addClothListButton,
         backToRegisterButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - UI Constraints config
    override func setupConstraints() {
        super.setupConstraints()
        
        resultImageView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(Metric.ResultImage.top)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Metric.ResultImage.height)
            $0.width.equalTo(Metric.width)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(resultImageView.snp.bottom).offset(Metric.ResultLabel.top)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(Metric.ResultLabel.width)
        }
        
        addClothListButton.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(backToRegisterButton.snp.top).offset(Metric.Buttons.bottom)
            $0.width.equalTo(Metric.Buttons.width)
            $0.height.equalTo(Metric.Buttons.height)
        }
        
        backToRegisterButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(Metric.Buttons.bottom)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(Metric.Buttons.width)
            $0.height.equalTo(Metric.Buttons.height)
        }
    }
}
