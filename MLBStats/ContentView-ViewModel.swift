//  ContentView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import Foundation
import SwiftUI

extension ContentView {
    @Observable class ViewModel {
        var hitters: [Hitter] = []
        var pitchers: [Pitcher] = []
        var fielders: [Fielder] = []
        var isLoading = false
        var currentView: CurrentView = .hitters
        
        enum CurrentView: String, CaseIterable {
            case hitters
            case pitchers
            case fielders
        }
        
        enum TimeFrame: String {
            case L2Y = "11" // Last 2 calendar years
            case LY = "10"  // Last 1 calendar year
            case L30 = "3"  // Last 30 days
        }
        
        // Default PA: 60, 25 for L30
        func fetchHitters(for teamID: Int? = nil, PA: Int = 60, timeFrame: TimeFrame = .L2Y, currentSeason: Int = 2024) async {
            isLoading = true
            defer { isLoading = false }
            var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=bat&lg=all&qual=\(PA)&pageitems=999&rost=1&season=\(currentSeason)&month=\(timeFrame.rawValue)"
            if let teamID = teamID {
                urlString += "&team=\(teamID)"
            }
            guard let url = URL(string: urlString) else {
                print("Error loading players URL")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(HittersResponse.self, from: data)
                DispatchQueue.main.async {
                    self.hitters = response.data
                }
            } catch {
                print("Error fetching or decoding hitters: \(error.localizedDescription)")
            }
        }
        
        // Default IP: 25, 10 for L30
        func fetchPitchers(for teamID: Int? = nil, IP: Int = 25, timeFrame: TimeFrame = .L2Y, currentSeason: Int = 2024) async {
            isLoading = true
            defer { isLoading = false }
            var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=pit&lg=all&qual=\(IP)&pageitems=999&rost=1&season=\(currentSeason)&month=\(timeFrame.rawValue)"
            if let teamID = teamID {
                urlString += "&team=\(teamID)"
            }
            guard let url = URL(string: urlString) else {
                print("Error loading players URL")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(PitchersResponse.self, from: data)
                DispatchQueue.main.async {
                    self.pitchers = response.data
                }
            } catch {
                print("Error fetching or decoding pitchers: \(error.localizedDescription)")
            }
        }
        
        func fetchFielders(for teamID: Int? = nil, startSeason: String? = nil, currentSeason: Int = 2024) async {
            isLoading = true
            defer { isLoading = false }
            var urlString = "https://www.fangraphs.com/api/leaders/major-league/data?pos=all&stats=fld&lg=all&qual=50&pageitems=999&rost=1&season=\(currentSeason)"
            if let startSeason = startSeason {
                urlString += "&season1=\(startSeason)"
            }
            if let teamID = teamID {
                urlString += "&team=\(teamID)"
            }
            guard let url = URL(string: urlString) else {
                print("Error loading fielders URL")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(FieldersResponse.self, from: data)
                self.fielders = response.data
            } catch {
                print("Error decoding fielders JSON: \(error.localizedDescription)")
            }
        }
        
        func loadCurrentViewData() async {
            switch currentView {
            case .hitters:
                await fetchHitters(PA: 25, timeFrame: .L30)
            case .pitchers:
                await fetchPitchers(IP: 10, timeFrame: .L30)
            case .fielders:
                await fetchFielders()
            }
        }
        
        func toggleView() {
            switch currentView {
            case .hitters:
                currentView = .pitchers
            case .pitchers:
                currentView = .fielders
            case .fielders:
                currentView = .hitters
            }
        }
    }
}
