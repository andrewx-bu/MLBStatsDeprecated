//  FielderStatsView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

extension FielderStatsView {
    @Observable class ViewModel {
        var fielders: [Fielder] = []
        var isLoading = false
        
        func fetchFielders(for teamID: Int? = nil, inn: Int = 50, startSeason: String? = nil, currentSeason: Int = 2024) async {
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
                self.fielders = response.data.filter { fielder in
                    fielder.pos != "P" && fielder.pos != "C"
                }
            } catch {
                print("Error fetching or decoding fielders JSON: \(error.localizedDescription)")
            }
        }
    }
}
