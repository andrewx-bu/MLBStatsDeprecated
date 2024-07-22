//  FielderStatsView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

extension FielderStatsView {
    @Observable class ViewModel {
        var fielders: [Fielder] = []
        var selectedSeasonRange: SeasonRange = .SZN {
            didSet {
                Task {
                    await fetchFielders(min: minimumIP, startSeason: selectedSeasonRange.startSeason)
                }
            }
        }
        var IPs = [175, 450, 700, 900]
        var minimumIP = 175 {
            didSet {
                Task {
                    await fetchFielders(min: minimumIP, startSeason: selectedSeasonRange.startSeason)
                }
            }
        }
        var isLoading = false
        
        /*
         By default, fetches fielder stats from the current season
         - inn: Min Playing Time (Inn)
         - startSeason: include stats starting from this season year
         - teamID: only include players on this team
         */
        func fetchFielders(min inn: Int = 175, currentSeason: Int = Int(Calendar.current.component(.year, from: Date())), startSeason: Int? = nil, for teamID: Int? = nil) async {
            isLoading = true
            defer { isLoading = false }
            var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=fld&lg=all&qual=\(inn)&pageitems=999&rost=1&season=\(currentSeason)"
            if let startSeason = startSeason {
                urlString += "&season1=\(startSeason)"
            }
            if let teamID = teamID {
                urlString += "&team=\(teamID)"
            }
            guard let url = URL(string: urlString) else {
                print("Error loading fielders URL")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(FieldersResponse.self, from: data)
                // exclude pitchers and catchers
                self.fielders = response.data.filter { fielder in
                    fielder.pos != "P" && fielder.pos != "C"
                }
            } catch {
                print("Error fetching or decoding fielders JSON: \(error.localizedDescription)")
            }
        }
    }
}
