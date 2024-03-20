//
//  Extension.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/2/24.
//

import UIKit

// MARK: - UITableViewCell extension
extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

// MARK: - UICollectionViewCell extension
extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

// MARK: - UICollectionViewListCell extension
extension UICollectionViewListCell {
    static var id: String {
        return String(describing: self)
    }
}
