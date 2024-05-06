//
//  ImageTempManager.swift
//  PersonalCloset
//
//  Created by Bowon Han on 4/30/24.
//

import Foundation

class ImageTempManager {
    static let shared = ImageTempManager()
    
    var imageURLs: [String] = []
    
    private init() {}
}
