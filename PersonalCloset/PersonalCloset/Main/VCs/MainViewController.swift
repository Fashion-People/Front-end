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
}

final class MainViewController: BaseViewController {
    weak var delegate: MainViewControllerDelegate?
    var locationManager = CLLocationManager()
    private let location = LocationManager.shared.location
    private let status: [WeatherItemType] = WeatherItemType.allCases
    
    private enum Metric {
        enum cameraButton {
            static let top: CGFloat = 20
            static let height: CGFloat = 200
            static let sideInset: CGFloat = 30
        }
        
        enum emptyView {
            static let top: CGFloat = 30
            static let inset: CGFloat = 30
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topView.backButton.isHidden = true
        self.topView.selectButton.isHidden = true
        
        self.setLocationManager()
//        self.fetchWeatherStatus()
    }
    
    // MARK: - UI config
    private lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .darkBlue
        button.layer.cornerRadius = 10
        button.backgroundColor = .skyBlue
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .light)
        let image = UIImage(systemName: "camera.fill", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        
        button.addAction(UIAction { _ in
            self.tabCameraButton()
            }, for: .touchUpInside
        )

        return button
    }()
    
    private let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .skyBlue
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    // MARK: - method
    private func tabCameraButton() {
        /// 카메라 버튼 눌렀을때
        delegate?.presentRegisterVC()
    }
    
    fileprivate func setLocationManager() {
        /// 델리게이트를 설정하고,
        locationManager.delegate = self
        /// 거리 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        /// 위치 사용 허용 알림
        locationManager.requestWhenInUseAuthorization()
        /// 위치 사용을 허용하면 현재 위치 정보를 가져옴
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
            }
            else {
                print("위치 서비스 허용 off")
            }
        }
    }
    
//    private func fetchWeatherStatus() {
//        Task {
//            do {
//                /// Fetch weather status from the server
//                try await WeatherAPI.fetchWeatherStatus(location.latitude,location.longtitude).performRequest()
//                
//                DispatchQueue.main.async {
////                    self.topView.weatherImage.image = UIImage(systemName: status.)
//                }
//                
//            } catch { print("error: \(error)") }
//        }
//    }
    
    // MARK: - UI layout config
    override func setupLayouts() {
        super.setupLayouts()
        
        [cameraButton, 
         emptyView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - UI Constraints config
    override func setupConstraints() {
        super.setupConstraints()
        
        cameraButton.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(Metric.cameraButton.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.cameraButton.sideInset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.cameraButton.sideInset)
            $0.height.equalTo(Metric.cameraButton.height)
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(cameraButton.snp.bottom).offset(Metric.emptyView.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.emptyView.inset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.emptyView.inset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Metric.emptyView.inset)
        }
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위치 업데이트!")
//            var setLocation = LocationManager.shared.location
            
            LocationManager.shared.location.latitude = String(location.coordinate.latitude)
            LocationManager.shared.location.longtitude = String(location.coordinate.longitude)
            
            var setLocation = LocationManager.shared.location
            
            Task {
                do {
                    /// Fetch weather status from the server
                    try await WeatherAPI.fetchWeatherStatus(setLocation.latitude, setLocation.longtitude).performRequest()
                    
                    DispatchQueue.main.async {
                        self.topView.weatherImage.image = UIImage(systemName: "sun.max")
                        print("성공")
                    }
                    
                } catch { print("error: \(error)") }
            }
            
            print(setLocation)
        }
    }
        
    /// 위치 가져오기 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}
