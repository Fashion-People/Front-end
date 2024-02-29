//
//  ListContentConfiguration.swift
//  PersonalCloset
//
//  Created by Bowon Han on 2/29/24.
//

import UIKit

struct ContentConfiguration: UIContentConfiguration, Hashable {
    var clothDescription: String?
    
    func makeContentView() -> UIView & UIContentView {
        return ListContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}
