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
    var clothDescription : String
    var clothImageURL : String
    
    init(clothDescription: String, clothImageURL: String) {
        self.clothDescription = clothDescription
        self.clothImageURL = clothImageURL
    }
}
