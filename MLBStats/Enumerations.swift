//  Enumerations.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import Foundation

enum TimeFrame: String, CaseIterable {
    case L3Y = "12" // Past 3 calendar years
    case L2Y = "11" // Past 2 calendar years
    case LY = "10"  // Past 1 calendar year
    case SZN = "33" // Current season
    case L30 = "3"  // Last 30 days
}

enum SeasonRange: String, CaseIterable {
    case L3Y
    case L2Y
    case LY
    case SZN
    
    var startSeason: Int? {
        switch self {
        case .L3Y:
            return Calendar.current.component(.year, from: Date()) - 3
        case .L2Y:
            return Calendar.current.component(.year, from: Date()) - 2
        case .LY:
            return Calendar.current.component(.year, from: Date()) - 1
        case .SZN:
            return nil
        }
    }
}
