//  Enumerations.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import Foundation

enum TimeFrame: String, CaseIterable {
    case L30 = "3"  // Last 30 days
    case SZN = "33" // Current season
    case LY = "10"  // Past 1 calendar year
    case L2Y = "11" // Past 2 calendar years
    case L3Y = "12" // Past 3 calendar years
}

enum SeasonRange: String, CaseIterable {
    case SZN
    case LY
    case L2Y
    case L3Y
    
    var startSeason: Int? {
        switch self {
        case .SZN:
            return nil
        case .LY:
            return Calendar.current.component(.year, from: Date()) - 1
        case .L2Y:
            return Calendar.current.component(.year, from: Date()) - 2
        case .L3Y:
            return Calendar.current.component(.year, from: Date()) - 3
        }
    }
}
