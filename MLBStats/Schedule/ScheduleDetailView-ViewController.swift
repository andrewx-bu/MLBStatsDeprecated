//  ScheduleDetailView-ViewController.swift
//  MLBStats
//  Created by Andrew Xin on 7/25/24.

import Foundation

extension ScheduleDetailView {
    @Observable class ViewModel {
        var awayBatters: [Int] = []
        var awayStartingPitchers: [Int] = []
        var awayBullpen: [Int] = []
        var homeBatters: [Int] = []
        var homeStartingPitchers: [Int] = []
        var homeBullpen: [Int] = []
        
        var teamHStats: [TeamHitting] = []
        var teamPStats: [TeamPitching] = []
        var teamFCStats: [TeamFieldingAndCatching] = []
        private let game: ScheduleDate.Game
        
        init(game: ScheduleDate.Game) {
            self.game = game
        }
        
        func fetchLineups() async {
            let urlString = "https://statsapi.mlb.com/api/v1.1/game/\(self.game.gamePk)/feed/live"
            guard let url = URL(string: urlString) else {
                print("Invalid game data URL")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(LiveDataResponse.self, from: data)
                DispatchQueue.main.async {
                    self.awayBatters = response.liveData.boxscore.teams.away.batters
                    self.awayStartingPitchers = response.liveData.boxscore.teams.away.pitchers
                    self.awayBullpen = response.liveData.boxscore.teams.away.bullpen
                    
                    self.homeBatters = response.liveData.boxscore.teams.home.batters
                    self.homeStartingPitchers = response.liveData.boxscore.teams.home.pitchers
                    self.homeBullpen = response.liveData.boxscore.teams.home.bullpen
                }
            } catch {
                print("Error fetching or decoding live game data JSON: \(error.localizedDescription)")
            }
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
