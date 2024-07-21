//  HitterStatsView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation
import SwiftUI

extension HitterStatsView {
    @Observable class ViewModel {
        var hitters: [Hitter] = []
        
        /*
         By default, fetches hitter stats from the past 3 calendar years
         - PA: Min Plate Appearances
         - default is 60 for L30D stats, 250 if farther back
         - timeFrame: include stats from L30 Days, L1 Calendar Year, or L2 Calendar Years
         - teamID: only include players on this team
         */
        func fetchHitters(min PA: Int? = nil, timeFrame: TimeFrame = .L3Y, currentSeason: Int = 2024, for teamID: Int? = nil) async {
            let PA = timeFrame == .L30 ? 60 : 250
            var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=bat&lg=all&qual=\(PA)&pageitems=999&rost=1&season=\(currentSeason)&month=\(timeFrame.rawValue)"
            if let teamID = teamID {
                urlString += "&team=\(teamID)"
            }
            guard let url = URL(string: urlString) else {
                print("Error loading hitters URL")
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
