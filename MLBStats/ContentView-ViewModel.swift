//  ContentView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import Foundation
import SwiftUI

extension ContentView {
    @Observable class ViewModel {
        var currentView: CurrentView = .hitters
        
        enum CurrentView: String, CaseIterable {
            case hitters
            case pitchers
            case fielders
            case catchers
        }
        
        enum TimeFrame: String {
            case L2Y = "11" // Last 2 calendar years
            case LY = "10"  // Last 1 calendar year
            case L30 = "3"  // Last 30 days
        }
    }
}
