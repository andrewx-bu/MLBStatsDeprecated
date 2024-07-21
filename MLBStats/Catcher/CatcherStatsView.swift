//  CatcherStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct CatcherStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        List(viewModel.catchers) { catcher in
            VStack(alignment: .leading) {
                HStack {
                    Text(catcher.name)
                        .font(.headline)
                    Text("(\(catcher.teamName))")
                }
                HStack {
                    Text("G: \(catcher.G)")
                        .font(.caption)
                    Spacer()
                    Text("Innings Played: \(catcher.inn, specifier: "%.2f")")
                        .font(.caption)
                }
                HStack {
                    Text("Putouts: \(catcher.PO)")
                        .font(.caption)
                    Spacer()
                    Text("Assists: \(catcher.A)")
                        .font(.caption)
                }
                HStack {
                    Text("Errors: \(catcher.E)")
                        .font(.caption)
                    Spacer()
                    Text("Double Plays: \(catcher.DP)")
                        .font(.caption)
                }
                HStack {
                    Text("Fielding %: \(catcher.FP, specifier: "%.3f")")
                        .font(.caption)
                    Spacer()
                    Text("Defensive Runs Saved: \(catcher.DRS)")
                        .font(.caption)
                }
                HStack {
                    if let csPCT = catcher.csPCT {
                        Text("CS %: \(csPCT, specifier: "%.2f")")
                            .font(.caption)
                    }
                    Spacer()
                    Text("Passed Balls: \(catcher.PB)")
                        .font(.caption)
                }
                HStack {
                    Text("Wild Pitches: \(catcher.WP)")
                        .font(.caption)
                    Spacer()
                    Text("DEF: \(catcher.DEF, specifier: "%.2f")")
                        .font(.caption)
                }
                HStack {
                    Text("Framing: \(catcher.FRM, specifier: "%.2f")")
                        .font(.caption)
                    Spacer()
                    Text("Fielding Run Value: \(catcher.FRV)")
                        .font(.caption)
                }
            }
            .padding()
        }
        .navigationTitle("MLB Catchers")
        .task {
            await viewModel.fetchCatchers()
        }
    }
}

#Preview {
    CatcherStatsView()
}
