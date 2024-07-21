//  PitcherStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct PitcherStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        List(viewModel.pitchers) { pitcher in
            VStack(alignment: .leading) {
                HStack {
                    Text("\(pitcher.name) (Pitches: \(pitcher.pitchHand))")
                        .font(.subheadline)
                    Spacer()
                    Text("Team: \(pitcher.teamName)")
                        .font(.subheadline)
                }
                HStack {
                    Text("Age: \(pitcher.age)")
                        .font(.caption)
                    Spacer()
                    Text("W-L: \(pitcher.W)-\(pitcher.L)")
                        .font(.caption)
                }
            }
        }
        .navigationTitle("MLB Pitchers")
        .task {
            await viewModel.fetchPitchers(timeFrame: .SZN)
        }
    }
}

#Preview {
    PitcherStatsView()
}
