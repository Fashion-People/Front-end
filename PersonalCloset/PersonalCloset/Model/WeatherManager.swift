//
//  WeatherManager.swift
//  PersonalCloset
//
//  Created by Bowon Han on 4/10/24.
//

import Foundation

class WeatherManager {
    static let shared = WeatherManager()
    
    var weather = WeatherModel(weatherStatus: "")
    
    private init() {}
}
