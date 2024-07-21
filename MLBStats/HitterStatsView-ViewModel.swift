//  HitterStatsView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation
import SwiftUI

extension HitterStatsView {
    @Observable class ViewModel {
        var hitters: [Hitter] = []
        var isLoading = false
        
        func fetchHitters(for teamID: Int? = nil, PA: Int = 60, timeFrame: ContentView.ViewModel.TimeFrame = .L2Y, currentSeason: Int = 2024) async {
            isLoading = true
            defer { isLoading = false }
            var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=bat&lg=all&qual=\(PA)&pageitems=999&rost=1&season=\(currentSeason)&month=\(timeFrame.rawValue)"
            if let teamID = teamID {
                urlString += "&team=\(teamID)"
            }
            guard let url = URL(string: urlString) else {
                print("Error loading players URL")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(HittersResponse.self, from: data)
                DispatchQueue.main.async {
                    self.hitters = response.data
                }
            } catch {
                print("Error fetching or decoding hitters JSON: \(error.localizedDescription)")
            }
        }
    }
}
