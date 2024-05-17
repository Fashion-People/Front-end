//
//  MainViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 12/30/23.
//

import UIKit
import SnapKit
import CoreLocation

protocol MainViewControllerDelegate: AnyObject {
    func presentMainVC()
    func presentRegisterVC()
    func presentAddImageVC()
}

final class MainViewController: BaseViewController {
    weak var delegate: MainViewControllerDelegate?
        
    private enum Metric {
        enum cameraButton {
            static let top: CGFloat = 20
            static let height: CGFloat = 200
            static let inset: CGFloat = 30
        }
        
        enum WeatherView {
            static let top: CGFloat = 30
            static let inset: CGFloat = 30
            static let height: CGFloat = 200
        }
        
        enum AddImageButton {
            static let top: CGFloat = 30
            static let inset: CGFloat = 30
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topView.backButton.isHidden = true
        self.topView.selectButton.isHidden = true
        
//        Task {
//            do {
//                /// Fetch weather status from the server
//                try await WeatherAPI.fetchWeatherStatus(LocationManager.shared.location.latitude, LocationManager.shared.location.longtitude).performRequest()
//
//                guard let weatherItemType = WeatherItemType(index: WeatherManager.shared.weatherInfo.weather) else {
//                    print("Unknown weather status: \(WeatherManager.shared.weatherInfo.weather)")
//                    return
//                }
//
//                DispatchQueue.main.async {
//                    self.topView.weatherImage.image = UIImage(systemName: weatherItemType.toIconName())
//                }
//
//            } catch { print("error: \(error)") }
//        }
    }
    
    // MARK: - UI config
    private lazy var cameraButton = MainViewButton(imageName: "camera.fill", action: UIAction { _ in
        self.delegate?.presentRegisterVC()
    })
    
//    private let weatherInfo = WeatherManager.shared.weatherInfo
    
    private lazy var weatherView = WeatherView(imageName: "sun.max")
    
    private lazy var addImageButton = MainViewButton(imageName: "plus", action: UIAction { _ in
        self.delegate?.presentAddImageVC()
    })

    // MARK: - UI layout config
    override func setupLayouts() {
        super.setupLayouts()
        
        [cameraButton,
         weatherView,
         addImageButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - UI Constraints config
    override func setupConstraints() {
        super.setupConstraints()
        
        cameraButton.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(Metric.cameraButton.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.cameraButton.inset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.cameraButton.inset)
            $0.height.equalTo(Metric.cameraButton.height)
        }
                
        weatherView.snp.makeConstraints {
            $0.top.equalTo(cameraButton.snp.bottom).offset(Metric.WeatherView.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.WeatherView.inset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.WeatherView.inset)
            $0.height.equalTo(Metric.WeatherView.height)
        }
        
        addImageButton.snp.makeConstraints {
            $0.top.equalTo(weatherView.snp.bottom).offset(Metric.AddImageButton.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.AddImageButton.inset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.AddImageButton.inset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Metric.AddImageButton.inset)
        }
    }
}
