//
//  TokenManager.swift
//  PersonalCloset
//
//  Created by Bowon Han on 3/12/24.
//

import Foundation

class TokenManager {
    static let shared = TokenManager()
    
    var token = Token.init(accessToken: "")
    
    private init() {}
}
