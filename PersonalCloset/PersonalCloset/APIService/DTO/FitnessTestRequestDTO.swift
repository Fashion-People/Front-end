//
//  FitnessTestRequestDTO.swift
//  PersonalCloset
//
//  Created by Bowon Han on 4/10/24.
//

import Foundation

struct FitnessTestRequestDTO: Codable {
    var imageUrl: [String]
    var latitude: String
    var longtitude: String
    var situation: String
}
