//  HitterStatsView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

extension HitterStatsView {
    @Observable class ViewModel {
        var hitters: [Hitter] = []
        var selectedTimeFrame: TimeFrame = .SZN {
            didSet {
                Task {
                    await fetchHitters(min: minimumPA, timeFrame: selectedTimeFrame)
                }
            }
        }
        var PAs = [50, 150, 300, 500, 700]
        var minimumPA = 50 {
            didSet {
                Task {
                    await fetchHitters(min: minimumPA, timeFrame: selectedTimeFrame)
                }
            }
        }
        var isLoading = false
        
        /*
         By default, fetches hitter stats from current season
         - PA: Min Plate Appearances
         - timeFrame: include stats from L30 Days, L1 Calendar Year, L2 Calendar Years, or L3
         - teamID: only include players on this team
         */
        func fetchHitters(min PA: Int = 50, timeFrame: TimeFrame = .SZN, currentSeason: Int = Int(Calendar.current.component(.year, from: Date())), for teamID: Int? = nil) async {
            isLoading = true
            defer { isLoading = false }
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
