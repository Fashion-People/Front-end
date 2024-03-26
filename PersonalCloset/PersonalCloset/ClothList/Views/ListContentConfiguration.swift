//
//  ListContentConfiguration.swift
//  PersonalCloset
//
//  Created by Bowon Han on 2/29/24.
//

import UIKit

struct ListContentConfiguration: UIContentConfiguration, Hashable {
    var clothDescription: String?
    var imageUrl: String?
    
    func makeContentView() -> UIView & UIContentView {
        return ListContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
    
//    func deleteList(indexPath: IndexPath) {
//        let cloth = ClothListManager.shared.clothList[indexPath.row]
//        ClothListManager.shared.clothList.remove(at: indexPath.row)
//        
//        Task {
//            do {
//                
//                try await ClothesAPI.deleteCloth(clothId: cloth.clothesNumber).performRequest()
//        
//            } catch {
//                print("error: \(error)")
//            }
//        }
//    }
}
