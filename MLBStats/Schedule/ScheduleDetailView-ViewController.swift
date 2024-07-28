//  ScheduleDetailView-ViewController.swift
//  MLBStats
//  Created by Andrew Xin on 7/25/24.

import Foundation

extension ScheduleDetailView {
    @Observable class ViewModel {
        var teamHStats: [TeamHitting] = []
        var teamPStats: [TeamPitching] = []
        var teamFCStats: [TeamFieldingAndCatching] = []
        private let game: ScheduleDate.Game
        
        init(game: ScheduleDate.Game) {
            self.game = game
        }
        
        func fetchHittingData(timeFrame: TimeFrame = .SZN) async {
            let urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=bat&lg=all&qual=y&season=2024&month=\(timeFrame.rawValue)&team=0%2Cts"
            guard let url = URL(string: urlString) else {
                print("Invalid team hitting URL")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(TeamHittingResponse.self, from: data)
                DispatchQueue.main.async {
                    guard let awayTeamMappedId = mapTeamId(fromStatsAPI: self.game.teams.away.team.id),
                          let homeTeamMappedId = mapTeamId(fromStatsAPI: self.game.teams.home.team.id) else {
                        print("Error: Team ID mapping failed")
                        return
                    }
                    
                    self.teamHStats = response.data.filter { stat in
                        stat.id == awayTeamMappedId || stat.id == homeTeamMappedId
                    }
                }
            } catch {
                print("Error fetching or decoding team hitting JSON: \(error.localizedDescription)")
            }
        }
        
        func fetchPitchingData(timeFrame: TimeFrame = .SZN) async {
            let urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=pit&lg=all&qual=y&season=2024&month=\(timeFrame.rawValue)&team=0%2Cts"
            guard let url = URL(string: urlString) else {
                print("Invalid team pitching URL")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(TeamPitchingResponse.self, from: data)
                DispatchQueue.main.async {
                    guard let awayTeamMappedId = mapTeamId(fromStatsAPI: self.game.teams.away.team.id),
                          let homeTeamMappedId = mapTeamId(fromStatsAPI: self.game.teams.home.team.id) else {
                        print("Error: Team ID mapping failed")
                        return
                    }
                    
                    self.teamPStats = response.data.filter { stat in
                        stat.id == awayTeamMappedId || stat.id == homeTeamMappedId
                    }
                }
            } catch {
                print("Error fetching or decoding team pitching JSON: \(error.localizedDescription)")
            }
        }
        
        func fetchFieldingAndCatchingData(timeFrame: TimeFrame = .SZN) async {
            let urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=fld&lg=all&qual=y&season=2024&month=\(timeFrame.rawValue)&team=0%2Cts"
            guard let url = URL(string: urlString) else {
                print("Invalid team fielding URL")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(TeamFieldingAndCatchingResponse.self, from: data)
                DispatchQueue.main.async {
                    guard let awayTeamMappedId = mapTeamId(fromStatsAPI: self.game.teams.away.team.id),
                          let homeTeamMappedId = mapTeamId(fromStatsAPI: self.game.teams.home.team.id) else {
                        print("Error: Team ID mapping failed")
                        return
                    }
                    
                    self.teamFCStats = response.data.filter { stat in
                        stat.id == awayTeamMappedId || stat.id == homeTeamMappedId
                    }
                }
            } catch {
                print("Error fetching or decoding team fielding JSON: \(error.localizedDescription)")
            }
        }
    }
}
