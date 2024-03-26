//
//  TabBarItemType.swift
//  PersonalCloset
//
//  Created by Bowon Han on 3/26/24.
//

import Foundation

enum TabBarItemType: String, CaseIterable {
    case main, list, setting
    
    // Int형에 맞춰 초기화
    init?(index: Int) {
        switch index {
        case 0: self = .main
        case 1: self = .list
        case 2: self = .setting
        default: return nil
        }
    }
    
    /// TabBarPage 형을 매칭되는 Int형으로 반환
    func toInt() -> Int {
        switch self {
        case .main: return 0
        case .list: return 1
        case .setting: return 2
        }
    }
    
    /// TabBarPage 형을 매칭되는 한글명으로 변환
    func toKrName() -> String {
        switch self {
        case .main: return "홈"
        case .list: return "커뮤니티"
        case .setting: return "추천"
        }
    }
    
    /// TabBarPage 형을 매칭되는 아이콘명으로 변환
    func toIconName() -> String {
        switch self {
        case .main: return "house"
        case .list: return "magnifyingglass"
        case .setting: return "heart"
        }
    }
}
