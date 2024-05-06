//
//  ClothListManager.swift
//  PersonalCloset
//
//  Created by Bowon Han on 3/12/24.
//

import Foundation

class ClothListManager{
    var clothList : [ClothListModel] = []
    
    static let shared = ClothListManager()

    private init() {}
}
