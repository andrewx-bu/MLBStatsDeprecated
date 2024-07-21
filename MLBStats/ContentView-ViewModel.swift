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
    }
}
