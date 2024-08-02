//  StatsView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import Foundation
import SwiftUI

extension StatsView {
    @Observable class ViewModel {
        var currentView: CurrentView = .Hitters
        
        enum CurrentView: String, CaseIterable {
            case Hitters
            case Pitchers
            case Fielders
            case Catchers
        }
    }
}
