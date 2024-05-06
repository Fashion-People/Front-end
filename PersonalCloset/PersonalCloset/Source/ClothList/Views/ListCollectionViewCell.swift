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
    var deleteAction: (() -> ()) = {}
    var modifyAction: (() -> ()) = {}

    /// UICellConfigurationState - cell의 상태를 캡슐화한 객체
    override func updateConfiguration(using state: UICellConfigurationState) {
        var config = ListContentConfiguration().updated(for: state)
        config.clothDescription = cloth.description
        config.imageUrl = cloth.imageUrl
        config.deleteAction = deleteAction
        config.modifyAction = modifyAction
        
        contentConfiguration = config
    }
}


