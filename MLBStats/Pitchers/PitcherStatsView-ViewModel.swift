//  PitcherStatsView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

extension PitcherStatsView {
    @Observable class ViewModel {
        var pitchers: [Pitcher] = []
        var selectedTimeFrame: TimeFrame = .SZN {
            didSet {
                Task {
                    await fetchPitchers(timeFrame: selectedTimeFrame)
                }
            }
        }
        
        /*
         By default, fetches pitcher stats from the past 3 calendar years
         - IP: Min Innings Pitched
         - default is 10 for L30D stats, 25 if farther back
         - timeFrame: include stats from L30 Days, L1 Calendar Year, or L2 Calendar Years, or L3
         - teamID: only include players on this team
         */
        func fetchPitchers(min IP: Int? = nil, timeFrame: TimeFrame = .L3Y, currentSeason: Int = Int(Calendar.current.component(.year, from: Date())), for teamID: Int? = nil) async {
            let IP = timeFrame == .L30 ? 10 : 25
            var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=pit&lg=all&qual=\(IP)&pageitems=999&rost=1&season=\(currentSeason)&month=\(timeFrame.rawValue)"
            if let teamID = teamID {
                urlString += "&team=\(teamID)"
            }
            guard let url = URL(string: urlString) else {
                print("Error loading pitchers URL")
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
