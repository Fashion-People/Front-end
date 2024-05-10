//
//  Weather.swift
//  PersonalCloset
//
//  Created by Bowon Han on 4/27/24.
//

import Foundation

enum WeatherItemType: String, CaseIterable {
    case clear, clouds, rain, snow, thunderstrom, mist
    
    /// Int형에 맞춰 초기화
    init?(index: String) {
        switch index {
        case "Clear": self = .clear
        case "Clouds": self = .clouds
        case "Rain": self = .rain
        case "Snow": self = .snow
        case "Thunderstorm": self = .thunderstrom
        case "Mist": self = .mist
        default: return nil
        }
    }
        
    /// TabBarPage 형을 매칭되는 아이콘명으로 변환
    func toIconName() -> String {
        switch self {
        case .clear: return "sun.max"
        case .clouds: return "cloud"
        case .rain: return "cloud.rain"
        case .snow: return "cloud.snow"
        case .thunderstrom: return "cloud.bolt.rain"
        case .mist: return "cloud.fog"
        }
    }
    
    
    func toStringKo() -> String {
        switch self {
        case .clear: return "맑음"
        case .clouds: return "흐림"
        case .rain: return "비"
        case .snow: return "눈"
        case .thunderstrom: return "번개"
        case .mist: return "안개"
        }
    }
}

