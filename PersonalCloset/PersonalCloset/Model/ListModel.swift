//
//  ListModel.swift
//  PersonalCloset
//
//  Created by Bowon Han on 2/27/24.
//

import Foundation

enum Section : CaseIterable {
    case main
}

struct ListModel: Codable, Hashable {
    let id = UUID()
    let clothDescription : String
    let clothImageURL : String
    
    init(clothDescription: String, clothImageURL: String) {
        self.clothDescription = clothDescription
        self.clothImageURL = clothImageURL
    }
}
