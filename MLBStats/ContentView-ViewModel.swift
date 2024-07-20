//  ContentView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import Foundation
import SwiftUI

extension ContentView {
    @Observable class ViewModel {
        var hitters: [Hitter] = []
        var pitchers: [Pitcher] = []
        
        enum TimeFrame: String {
            case L2Y = "11" // Last 2 calendar years
            case LY = "10"  // Last 1 calendar year
            case L30 = "3"  // Last 30 days
        }
        
        // Default PA: 60, 25 for L30
        func fetchHitters(for teamID: Int? = nil, PA: Int, timeFrame: TimeFrame) {
            var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=bat&lg=all&qual=\(PA)&pageitems=999&rost=1&season=2024&month=\(timeFrame.rawValue)"
            if let teamID = teamID {
                urlString += "&team=\(teamID)"
            }
            guard let url = URL(string: urlString) else {
                print("Error loading players URL")
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(HittersResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.hitters = response.data
                        }
                    } catch {
                        print("Error decoding players JSON: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
        
        // Default IP: 25, 10 for L30
        func fetchPitchers(for teamID: Int? = nil, IP: Int, timeFrame: TimeFrame) {
            var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=pit&lg=all&qual=\(IP)&pageitems=999&rost=1&season=2024&month=\(timeFrame.rawValue)"
            if let teamID = teamID {
                urlString += "&team=\(teamID)"
            }
            guard let url = URL(string: urlString) else {
                print("Error loading players URL")
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(PitchersResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.pitchers = response.data
                        }
                    } catch {
                        print("Error decoding players JSON: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
    }
}
