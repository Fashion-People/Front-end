//
//  BaseViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit
import SnapKit
import CoreLocation

class BaseViewController : UIViewController {
    // MARK: - Property
    private(set) var didSetupConstraints = false
    
    private var locationManager = CLLocationManager()
    private let location = LocationManager.shared.location
    
    private enum Metric {
        static let top: CGFloat = 10
        static let trailing: CGFloat = -10
        static let height: CGFloat = 80
    }
    
    // MARK: - Initializing
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        self.view.setNeedsUpdateConstraints()
        self.setLocationManager()
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupLayouts()
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }

    // MARK: - Top View
    lazy var topView = TopView()
    
    fileprivate func setLocationManager() {
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
    
    func setupLayouts() {
        view.addSubview(topView)
    }
    
    // MARK: - UI Constraints config
    func setupConstraints() {
        topView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Metric.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(Metric.trailing)
            $0.height.equalTo(Metric.height)
        }
    }
}

extension BaseViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위치 업데이트!")
            
            LocationManager.shared.location.latitude = String(location.coordinate.latitude)
            LocationManager.shared.location.longtitude = String(location.coordinate.longitude)
            
            let setLocation = LocationManager.shared.location
                        
            Task {
                do {
                    /// Fetch weather status from the server
                    try await WeatherAPI.fetchWeatherStatus(setLocation.latitude, setLocation.longtitude).performRequest()
                                        
                    guard let weatherItemType = WeatherItemType(index: WeatherManager.shared.weatherInfo.weather) else {
                        print("Unknown weather status: \(WeatherManager.shared.weatherInfo.weather)")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.topView.weatherImage.image = UIImage(systemName: weatherItemType.toIconName())
                    }
                    
                } catch { print("error: \(error)") }
            }
            print(setLocation)
        }
    }
        
    /// 위치 가져오기 실패시 호출
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}
