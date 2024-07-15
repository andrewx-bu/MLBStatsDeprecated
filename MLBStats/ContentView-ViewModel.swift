//  ContentView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import Foundation
import SwiftUI

extension ContentView {
    @Observable class ViewModel {
        var players: [Player] = []
        
        func fetchPlayers() {
            guard let url = URL(string: "https://statsapi.mlb.com/api/v1/sports/1/players?season=2025") else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(PlayerResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.players = response.people
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }.resume()
        }
    }
}
