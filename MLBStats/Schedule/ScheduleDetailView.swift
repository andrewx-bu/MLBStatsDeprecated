//
//  ScheduleDetailView.swift
//  MLBStats
//
//  Created by Andrew Xin on 7/25/24.
//

import SwiftUI

struct ScheduleDetailView: View {
    let viewModel: ViewModel
    let game: ScheduleDate.Game
    
    init(game: ScheduleDate.Game) {
        self.game = game
        viewModel = ViewModel(game: game)
    }
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                Text("\(game.teams.away.team.name) @ \(game.teams.home.team.name)")
                    .font(.headline)
                Text("Score: \(game.teams.away.score ?? 0)-\(game.teams.home.score ?? 0)")
                    .font(.headline)
                Text("Team Stats")
                    .font(.title2)
                    .padding(.top)
                Divider()
                ForEach(viewModel.teamHStats, id: \.id) { stat in
                    VStack(alignment: .leading) {
                        Text("Team: \(stat.name)")
                            .font(.headline)
                        Text("AVG: \(stat.AVG, specifier: "%.2f")")
                    }
                    .padding(.bottom)
                }
                Divider()
                ForEach(viewModel.teamPStats, id: \.id) { stat in
                    VStack(alignment: .leading) {
                        Text("Team: \(stat.name)")
                            .font(.headline)
                        Text("ERA: \(stat.ERA, specifier: "%.2f")")
                    }
                    .padding(.bottom)
                }
                Divider()
                ForEach(viewModel.teamFCStats, id: \.id) { stat in
                    VStack(alignment: .leading) {
                        Text("Team: \(stat.name)")
                            .font(.headline)
                        Text("UZR: \(stat.UZR, specifier: "%.2f")")
                    }
                    .padding(.bottom)
                }
                Divider()
                Text("Home Team Batters")
                    .font(.headline)
                ForEach(viewModel.homeBatters, id: \.self) { batterId in
                    Text("BatterID: \(batterId)")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationBarTitle("Game Details", displayMode: .inline)
        .task {
            await viewModel.fetchHittingData()
            await viewModel.fetchPitchingData()
            await viewModel.fetchFieldingAndCatchingData()
            await viewModel.fetchLineups()
        }
    }
}

// Preview
#Preview {
    ScheduleDetailViewPreview()
        .previewDisplayName("Schedule Detail Preview")
}

struct ScheduleDetailViewPreview: View {
    @State private var game: ScheduleDate.Game? = nil
    
    var body: some View {
        VStack {
            if let game = game {
                ScheduleDetailView(game: game)
            } else {
                ProgressView("Loading...")
                    .onAppear {
                        Task {
                            self.game = await fetchGame()
                        }
                    }
            }
        }
        .padding()
    }
    
    func fetchGame(date: Date? = nil) async -> ScheduleDate.Game? {
        var urlString = "https://statsapi.mlb.com/api/v1/schedule?sportId=1"
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateString = dateFormatter.string(from: date)
            urlString += "&date=\(dateString)"
        }
        guard let url = URL(string: urlString) else {
            print("Invalid schedule URL")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(ScheduleResponse.self, from: data)
            // Using first game that day for preview
            if let firstDate = response.dates.first, let firstGame = firstDate.games.first {
                return firstGame
            } else {
                print("No games found for the selected date.")
                return nil
            }
        } catch {
            print("Error fetching or decoding schedule JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
