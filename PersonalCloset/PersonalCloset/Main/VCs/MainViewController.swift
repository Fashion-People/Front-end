//
//  MainViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 12/30/23.
//

import UIKit
import SnapKit
import CoreLocation

protocol MainViewControllerDelegate : AnyObject {
    func presentMainVC()
    func presentRegisterVC()
}

final class MainViewController : BaseViewController {
    weak var delegate : MainViewControllerDelegate?
    var locationManager = CLLocationManager()
    
    private enum Metric {
        enum cameraButton {
            static let top: CGFloat = 20.0
            static let height: CGFloat = 200.0
            static let sideInset: CGFloat = 30.0
        }
        
        enum emptyView {
            static let inset: CGFloat = 30.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.backButton.isHidden = true
        topView.selectButton.isHidden = true
        
        self.setLocationManager()
    }
    
    // MARK: - UI config
    private lazy var cameraButton : UIButton = {
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
    
    private let emptyView : UIView = {
        let view = UIView()
        view.backgroundColor = .skyBlue
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    // MARK: - method
    private func tabCameraButton() {
        // 카메라 버튼 눌렀을때
        delegate?.presentRegisterVC()
    }
    
    fileprivate func setLocationManager() {
        // 델리게이트를 설정하고,
        locationManager.delegate = self
        // 거리 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 사용 허용 알림
        locationManager.requestWhenInUseAuthorization()
        // 위치 사용을 허용하면 현재 위치 정보를 가져옴
        if CLLocationManager.locationServicesEnabled() {
           locationManager.startUpdatingLocation()
        }
        else {
            print("위치 서비스 허용 off")
        }
    }
    
    // MARK: - UI layout config
    override func setLayout() {
        super.setLayout()
        
        [cameraButton, 
         emptyView].forEach {
            view.addSubview($0)
        }
        
        cameraButton.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(Metric.cameraButton.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(Metric.cameraButton.sideInset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Metric.cameraButton.sideInset)
            $0.height.equalTo(Metric.cameraButton.height)
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(cameraButton.snp.bottom).offset(Metric.emptyView.inset)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Metric.emptyView.inset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(Metric.emptyView.inset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(Metric.emptyView.inset)
        }
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위치 업데이트!")
            var setLocation = LocationManager.shared.location
            
            setLocation.latitude = String(location.coordinate.latitude)
            setLocation.longtitude = String(location.coordinate.longitude)
            
            print(setLocation)
        }
    }
        
    // 위치 가져오기 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}
