//
//  WeatherView.swift
//  PersonalCloset
//
//  Created by Bowon Han on 5/10/24.
//

import UIKit
import SnapKit

final class WeatherView: UIView {
    private let imageName: String
    private let temperatureInfo: String
    private let windChillInfo: String
    private let humidityInfo: String
    
    init(imageName: String, temperature: Float, windChill: Float, humidity: Float) {
        self.imageName = imageName
        self.temperatureInfo = String(temperature)
        self.windChillInfo = String(windChill)
        self.humidityInfo = String(humidity)
        super.init(frame: .zero)
        self.backgroundColor = .skyBlue
        self.setupLayouts()
        self.setupConstraints()
        self.setupStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private var contentView = UIView()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "오늘의 날씨"
        label.textColor = .darkBlue
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let image = UIImageView()
        image.tintColor = .gray
        
        return image
    }()
    
    private lazy var temperature: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        
        return label
    }()
    
    private lazy var windChillDescription: UILabel = {
        let label = UILabel()
        label.text = "체감"
        label.textColor = .darkBlue
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        return label
    }()
    
    private lazy var windChill: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        
        return label
    }()
    
    private lazy var humidityDescription: UILabel = {
        let label = UILabel()
        label.text = "습도"
        label.textColor = .darkBlue
        label.font = .systemFont(ofSize: 15, weight: .regular)

        return label
    }()
    
    private lazy var humidity: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)

        return label
    }()
    
    private func setupStyles() {
        weatherIcon.image = UIImage(systemName: imageName)
        temperature.text = temperatureInfo
        windChill.text = windChillInfo
        humidity.text = humidityInfo
    }
    
    private func setupLayouts() {
        self.layer.shadowColor = UIColor(hexCode: "c4c4c4").cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 7
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .skyBlue
        
        [title,
         weatherIcon,
         temperature,
         windChillDescription,
         windChill,
         humidityDescription,
         humidity].forEach {
            contentView.addSubview($0)
        }
        
        self.addSubview(contentView)
    }
    
    private func setupConstraints() {
        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(90)
            $0.height.width.equalTo(50)
        }
        
        temperature.snp.makeConstraints {
            $0.top.equalTo(weatherIcon.snp.top)
            $0.leading.equalTo(weatherIcon.snp.trailing).offset(5)
        }
        
        windChillDescription.snp.makeConstraints {
            $0.top.equalTo(temperature.snp.bottom).offset(15)
            $0.leading.equalTo(weatherIcon.snp.leading)
        }
        
        windChill.snp.makeConstraints {
            $0.top.equalTo(windChillDescription.snp.top)
            $0.leading.equalTo(windChillDescription.snp.trailing).offset(5)
            $0.bottom.equalTo(windChillDescription.snp.bottom)
        }
        
        humidityDescription.snp.makeConstraints {
            $0.top.equalTo(windChillDescription.snp.top)
            $0.bottom.equalTo(windChillDescription.snp.bottom)
            $0.trailing.equalTo(humidity.snp.leading).offset(-5)
        }
        
        humidity.snp.makeConstraints {
            $0.top.equalTo(windChillDescription.snp.top)
            $0.bottom.equalTo(windChillDescription.snp.bottom)
            $0.trailing.equalTo(temperature.snp.trailing)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
