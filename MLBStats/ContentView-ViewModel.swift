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
            case L2Y = "11"
            case LY = "10"
            case L30 = "3"
        }
        
        func fetchHitters(for teamID: Int? = nil, timeFrame: TimeFrame) {
            var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=bat&lg=all&qual=60&season=2024&month=\(timeFrame.rawValue)"
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
        
        func fetchPitchers(for teamID: Int? = nil, timeFrame: TimeFrame) {
            var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=pit&lg=all&qual=60&season=2024&month=\(timeFrame.rawValue)"
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
