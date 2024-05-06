//
//  WeatherManager.swift
//  PersonalCloset
//
//  Created by Bowon Han on 4/10/24.
//

import Foundation

class WeatherManager {
    var weather = WeatherModel(weatherStatus: "")
    
    static let shared = WeatherManager()
    
    private init() {}
}
