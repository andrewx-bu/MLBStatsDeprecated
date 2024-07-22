//  CatcherStatsView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

extension CatcherStatsView {
    @Observable class ViewModel {
        var catchers: [Catcher] = []
        var selectedSeasonRange: SeasonRange = .SZN {
            didSet {
                Task {
                    await fetchCatchers(min: minimumIP, startSeason: selectedSeasonRange.startSeason)
                }
            }
        }
        var IPs = [40, 100, 250, 500]
        var minimumIP = 40 {
            didSet {
                Task {
                    await fetchCatchers(min: minimumIP, startSeason: selectedSeasonRange.startSeason)
                }
            }
        }
        var isLoading = false
        
        /*
         By default, fetches catcher stats from the current season
         - inn: Min Playing Time (Inn)
         - startSeason: include stats starting from this season year
         - teamID: only include players on this team
         */
        func fetchCatchers(min inn: Int = 40, currentSeason: Int = Int(Calendar.current.component(.year, from: Date())), startSeason: Int? = nil, for teamID: Int? = nil) async {
            isLoading = true
            defer { isLoading = false }
            var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=c&stats=fld&lg=all&qual=\(inn)&pageitems=999&rost=1&season=\(currentSeason)"
            if let startSeason = startSeason {
                urlString += "&season1=\(startSeason)"
            }
            if let teamID = teamID {
                urlString += "&team=\(teamID)"
            }
            guard let url = URL(string: urlString) else {
                print("Error loading catchers URL")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(CatchersResponse.self, from: data)
                DispatchQueue.main.async {
                    self.catchers = response.data
                }
            } catch {
                print("Error fetching or decoding catchers JSON: \(error.localizedDescription)")
            }
        }
    }
}
