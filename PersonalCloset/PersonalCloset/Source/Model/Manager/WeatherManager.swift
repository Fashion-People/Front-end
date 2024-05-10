//
//  WeatherManager.swift
//  PersonalCloset
//
//  Created by Bowon Han on 4/10/24.
//

import Foundation

class WeatherManager {
    var weatherInfo = WeatherModel(weather: "", windChillfactor: 0, temperature: 0, humidity: 0)
    
    static let shared = WeatherManager()
    
    private init() {}
}
