//  CatcherStatsView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

extension CatcherStatsView {
    @Observable class ViewModel {
        var catchers: [Catcher] = []
        var isLoading = false
        
        func fetchCatchers(for teamID: Int? = nil, inn: Int = 40, startSeason: String? = nil, currentSeason: Int = 2024) async {
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
