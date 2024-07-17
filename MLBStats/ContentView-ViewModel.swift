//  ContentView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import Foundation
import SwiftUI

extension ContentView {
    @Observable class ViewModel {
        var players: [Player] = []
        var teams: [Team] = []
        var umpires: [Umpire] = []
        
        func fetchAllData() {
            fetchTeams()
            fetchPlayers()
            fetchUmpires()
        }
        
        // Fetches players active in the currents season. Year in link is one year ahead
        // URL: https://statsapi.mlb.com/api/{ver}/sports/{sportId}/players
        func fetchPlayers() {
            guard let url = URL(string: "https://statsapi.mlb.com/api/v1/sports/1/players?season=2025") else {
                print("Error loading players URL")
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(PlayerResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.players = response.people
                        }
                    } catch {
                        print("Error decoding players JSON: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
        
        // Fetches teams
        // URL: https://statsapi.mlb.com/api/{ver}/teams
        func fetchTeams() {
            guard let url = URL(string: "https://statsapi.mlb.com/api/v1/teams?leagueIds=103,104") else {
                print("Error loading teams URL")
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(TeamResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.teams = response.teams
                        }
                    } catch {
                        print("Error decoding teams JSON: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
        
        // Fetches umpires
        // URL: https://statsapi.mlb.com/api/{ver}/jobs/umpires
        func fetchUmpires() {
            guard let url = URL(string: "https://statsapi.mlb.com/api/v1/jobs/umpires") else {
                print("Error loading umpires URL")
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(UmpireResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.umpires = response.roster
                        }
                    } catch {
                        print("Error decoding umpires JSON: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
    }
}
