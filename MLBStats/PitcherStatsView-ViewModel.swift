//  PitcherStatsView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

extension PitcherStatsView {
    @Observable class ViewModel {
        var pitchers: [Pitcher] = []
        var isLoading = false
        
        func fetchPitchers(for teamID: Int? = nil, IP: Int = 25, timeFrame: ContentView.ViewModel.TimeFrame = .L2Y, currentSeason: Int = 2024) async {
            isLoading = true
            defer { isLoading = false }
            var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=pit&lg=all&qual=\(IP)&pageitems=999&rost=1&season=\(currentSeason)&month=\(timeFrame.rawValue)"
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
                let response = try decoder.decode(PitchersResponse.self, from: data)
                DispatchQueue.main.async {
                    self.pitchers = response.data
                }
            } catch {
                print("Error fetching or decoding pitchers JSON: \(error.localizedDescription)")
            }
        }
    }
}
