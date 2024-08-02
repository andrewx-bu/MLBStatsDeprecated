// StatsViewModel.swift
// MLBStats
// Created by Andrew Xin on 8/01/24.

import Foundation

@Observable class StatsViewModel {
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
    
    enum PlayerType {
        case hitter
        case pitcher
    }
    
    
    func fetchPlayers(type: PlayerType, min: Int, timeFrame: TimeFrame = .SZN, currentSeason: Int = Int(Calendar.current.component(.year, from: Date())), for teamID: Int? = nil) async {
        isLoading = true
        defer { isLoading = false }
        
        // Determine URL and Decoding Type
        let (stats, decodeType): (String, Decodable.Type)
        switch type {
        case .hitter:
            stats = "bat"
            decodeType = HittersResponse.self
        case .pitcher:
            stats = "pit"
            decodeType = PitchersResponse.self
        }
        
        // Construct URL
        var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=\(stats)&lg=all&qual=\(min)&pageitems=999&rost=1&season=\(currentSeason)&month=\(timeFrame.rawValue)"
        if let teamID = teamID {
            urlString += "&team=\(teamID)"
        }
        guard let url = URL(string: urlString) else {
            print("Invalid players URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(decodeType, from: data)
            
            DispatchQueue.main.async {
                switch type {
                case .hitter:
                    self.hitters = (response as? HittersResponse)?.data ?? []
                case .pitcher:
                    self.pitchers = (response as? PitchersResponse)?.data ?? []
                }
            }
            
        } catch {
            print("Error fetching or decoding players JSON: \(error.localizedDescription)")
        }
    }
}
