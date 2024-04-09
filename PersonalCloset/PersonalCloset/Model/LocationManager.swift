//
//  LocationManager.swift
//  PersonalCloset
//
//  Created by Bowon Han on 4/5/24.
//

import Foundation

class LocationManager {
    static let shared = LocationManager()
    
    var location = LocationModel(latitude: "", longtitude: "")
    
    private init() {}
}
