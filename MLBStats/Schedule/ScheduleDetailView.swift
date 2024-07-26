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
        VStack(alignment: .leading) {
            Text("Game Details")
                .font(.largeTitle)
                .padding()
            Text("\(game.teams.away.team.name) @ \(game.teams.home.team.name)")
                .font(.headline)
            Text("Score: \(game.teams.away.score ?? 0)-\(game.teams.home.score ?? 0)")
                .font(.headline)
            Text("Team Stats")
                .font(.title2)
                .padding(.top)
            ForEach(viewModel.teamStats, id: \.id) { stat in
                VStack(alignment: .leading) {
                    Text("Team: \(stat.name)")
                        .font(.headline)
                    Text("Games Played: \(stat.G)")
                    Text("Innings Played: \(stat.inn)")
                    Text("Putouts: \(stat.PO)")
                    Text("Assists: \(stat.A)")
                    Text("Errors: \(stat.E)")
                    Text("Double Plays: \(stat.DP)")
                    Text("Stolen Bases: \(stat.SB)")
                    Text("Caught Stealing: \(stat.CS)")
                    if let csPCT = stat.csPCT {
                        Text("Caught Stealing PCT: \(csPCT, specifier: "%.2f")")
                    }
                    Text("Passed Balls: \(stat.PB)")
                    Text("Wild Pitches: \(stat.WP)")
                    Text("Fielding Percentage: \(stat.FP, specifier: "%.3f")")
                    Text("Defensive Runs Saved: \(stat.DRS)")
                    Text("Ultimate Zone Rating: \(stat.UZR, specifier: "%.2f")")
                    Text("UZR per 150 Games: \(stat.UZRper150, specifier: "%.2f")")
                    Text("Defensive Runs Above Average: \(stat.DEF, specifier: "%.2f")")
                    Text("Catcher Framing: \(stat.FRM, specifier: "%.2f")")
                    Text("Outs Above Average: \(stat.OAA)")
                    Text("Fielding Run Value: \(stat.FRV)")
                }
                .padding(.bottom)
            }
        }
        .task {
            await viewModel.fetchFieldingAndCatchingData()
        }
    }
}
