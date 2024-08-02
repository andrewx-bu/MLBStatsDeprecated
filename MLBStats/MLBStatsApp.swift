//  MLBStatsApp.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import SwiftUI
import SDWebImageSVGCoder

@main
struct MLBStatsApp: App {
        init() {
            setUpDependencies() // Initialize SVGCoder
        }
        var body: some Scene {
            WindowGroup {
                HomeView()
            }
        }
}

// Initialize SVGCoder
private extension MLBStatsApp {
    func setUpDependencies() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
}
