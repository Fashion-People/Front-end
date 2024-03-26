//
//  ListCollectionViewCell.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/17/24.
//

import UIKit
import SnapKit

final class ListCollectionViewCell: UICollectionViewListCell {
    var cloth: ClothListModel!
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var config = ContentConfiguration().updated(for: state)
        config.clothDescription = cloth.description
        config.imageUrl = cloth.imageUrl
        
        contentConfiguration = config
    }
}


