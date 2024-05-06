//
//  UserRequestDTO.swift
//  PersonalCloset
//
//  Created by Bowon Han on 3/12/24.
//

import Foundation

struct UserRequestDTO: Codable {
    var email: String
    var loginId: String
    var name: String
    var password: String
    var style1: String
    var style2: String
    var style3: String
    var style4: String
}
