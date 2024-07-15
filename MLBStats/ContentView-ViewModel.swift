//  ContentView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import Foundation

class ViewModel: ObservableObject {
    @Published var players: [Player] = []
    @Published var errorMessage: String? = nil
    
    func fetchPlayers() {
        guard let url = URL(string: "http://127.0.0.1:5000/sports_players?sportId=1&season=2023") else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }
            
            do {
                // Print raw data for debugging
                if let json = String(data: data, encoding: .utf8) {
                    print("Raw JSON: \(json)")
                }
                let response = try JSONDecoder().decode(PlayersResponse.self, from: data)
                DispatchQueue.main.async {
                    self.players = response.people ?? []
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
