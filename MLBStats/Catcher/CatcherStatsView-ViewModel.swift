//  CatcherStatsView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

extension CatcherStatsView {
    @Observable class ViewModel {
        var catchers: [Catcher] = []
        
        /*
         By default, fetches catcher stats from the current season
         - inn: Min Playing Time (Inn)
         - default is 40 for current season stats, 400 if farther back
         - startSeason: include stats starting from this season year
         - teamID: only include players on this team
         */
        func fetchCatchers(min inn: Int? = nil, currentSeason: Int = Int(Calendar.current.component(.year, from: Date())), startSeason: String? = nil, for teamID: Int? = nil) async {
            let inn = inn ?? (startSeason == nil ? 40 : 400)
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
