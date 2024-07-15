//  ContentView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import Foundation
import SwiftUI

extension ContentView {
    @Observable class ViewModel {
        var players: [Player] = []
        var teams: [Team] = []
        
        func fetchData() {
            fetchTeams()
            fetchSports_Players()
        }
        
        // Fetches players active in the currents season. Year in link is one year ahead
        // URL: https://statsapi.mlb.com/api/{ver}/sports/{sportId}/players
        func fetchSports_Players() {
            guard let url = URL(string: "https://statsapi.mlb.com/api/v1/sports/1/players?season=2025") else {
                print("Error loading sports_players URL")
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
                        print("Error decoding sports_players JSON: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
        
        // Fetches teams
        // URL: https://statsapi.mlb.com/api/{ver}/teams
        func fetchTeams() {
            guard let url = URL(string: "https://statsapi.mlb.com/api/v1/teams?leagueIds=103,104") else {
                print("Error loading Teams URL")
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
        
        // Future fetches
    }
}
