// StatsViewModel.swift
// MLBStats
// Created by Andrew Xin on 8/01/24.

import Foundation

@Observable class HPStatsViewModel {
    var hitters: [Hitter] = []
    var pitchers: [Pitcher] = []
    var selectedTimeFrame: TimeFrame = .SZN {
        didSet {
            Task {
                await fetchHitters(min: minimumPA, timeFrame: selectedTimeFrame)
                await fetchPitchers(min: minimumIP, timeFrame: selectedTimeFrame)
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
    var IPs = [25, 100, 150, 250, 375]
    var minimumIP = 25 {
        didSet {
            Task {
                await fetchPitchers(min: minimumIP, timeFrame: selectedTimeFrame)
            }
        }
    }
    var isLoading = false
    
    func fetchHitters(min PA: Int = 50, timeFrame: TimeFrame = .SZN, currentSeason: Int = Int(Calendar.current.component(.year, from: Date())), for teamID: Int? = nil) async {
        isLoading = true
        defer { isLoading = false }
        var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=bat&lg=all&qual=\(PA)&pageitems=999&rost=1&season=\(currentSeason)&month=\(timeFrame.rawValue)"
        if let teamID = teamID {
            urlString += "&team=\(teamID)"
        }
        guard let url = URL(string: urlString) else {
            print("Invalid hitters URL")
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
    
    func fetchPitchers(min IP: Int = 25, timeFrame: TimeFrame = .SZN, currentSeason: Int = Int(Calendar.current.component(.year, from: Date())), for teamID: Int? = nil) async {
        isLoading = true
        defer { isLoading = false }
        var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=pit&lg=all&qual=\(IP)&pageitems=999&rost=1&season=\(currentSeason)&month=\(timeFrame.rawValue)"
        if let teamID = teamID {
            urlString += "&team=\(teamID)"
        }
        guard let url = URL(string: urlString) else {
            print("Invalid pitchers URL")
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
