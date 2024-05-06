//
//  ListContentConfiguration.swift
//  PersonalCloset
//
//  Created by Bowon Han on 2/29/24.
//

import UIKit

struct ListContentConfiguration: UIContentConfiguration {
    var clothDescription: String?
    var imageUrl: String?
    var deleteAction: (()->()) = {}
    var modifyAction: (()->()) = {}
    
    func makeContentView() -> UIView & UIContentView {
        return ListContentView(configuration: self, deleteAction: deleteAction, modifyAction: modifyAction)
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}
