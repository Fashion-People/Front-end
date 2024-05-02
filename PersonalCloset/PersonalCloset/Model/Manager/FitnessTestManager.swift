//
//  FitnessTestManager.swift
//  PersonalCloset
//
//  Created by Bowon Han on 4/30/24.
//

import Foundation

class FitnessTestManager {
    static let shared = FitnessTestManager()
    
    var result = FitnessTestModel(clothesNumber: 0, imageUrl: "", figure: 0,message: "")
    
    private init() {}
}
