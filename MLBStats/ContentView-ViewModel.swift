//  ContentView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import Foundation
import SwiftUI

extension ContentView {
    @Observable class ViewModel {
        var players: [Player] = []
        
        func fetchPlayers() {
            guard let url = URL(string: "https://www.fangraphs.com/api/leaders/major-league/data?age=&pos=all&stats=bat&lg=all&qual=60&season=2024&season1=2023&startdate=2024-03-01&enddate=2024-11-01&month=11&hand=&team=0&pageitems=2000000000&pagenum=1&ind=0&rost=1&players=0&type=8&postseason=&sortdir=default&sortstat=WAR") else {
                print("Error loading players URL")
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(PlayersResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.players = response.data
                        }
                    } catch {
                        print("Error decoding players JSON: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
    }
}
