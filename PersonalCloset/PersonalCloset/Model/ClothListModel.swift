//
//  ListModel.swift
//  PersonalCloset
//
//  Created by Bowon Han on 3/5/24.
//

import Foundation

enum Section : CaseIterable {
    case main
}

struct ClothListModel: Codable, Hashable {
    let clothesNumber: Int
    var description : String
    var imageUrl: String
    let userNumber: Int
}
