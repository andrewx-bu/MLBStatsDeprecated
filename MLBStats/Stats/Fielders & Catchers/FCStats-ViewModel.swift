//  FCStats-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 8/1/24.

import Foundation

@Observable class FCStatsViewModel {
    var fielders: [Fielder] = []
    var catchers: [Catcher] = []
    var selectedSeasonRange: SeasonRange = .SZN {
        didSet {
            Task {
                await fetchFielders(min: minimumIP, startSeason: selectedSeasonRange.startSeason)
                await fetchCatchers(min: minimumCIP, startSeason: selectedSeasonRange.startSeason)
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
    var CIPs = [40, 100, 250, 500]
    var minimumCIP = 40 {
        didSet {
            Task {
                await fetchCatchers(min: minimumCIP, startSeason: selectedSeasonRange.startSeason)
            }
        }
    }
    var isLoading = false
    
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
            print("Invalid fielders URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(FieldersResponse.self, from: data)
            DispatchQueue.main.async {
                // exclude pitchers and catchers
                self.fielders = response.data.filter { fielder in
                    fielder.pos != "P" && fielder.pos != "C"
                }
            }
        } catch {
            print("Error fetching or decoding fielders JSON: \(error.localizedDescription)")
        }
    }
    
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
            print("Invalid catchers URL")
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
