//  PitcherStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct PitcherStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        List(viewModel.pitchers, id: \.self) { pitcher in
            VStack(alignment: .leading) {
                Text(pitcher.Name)
                    .font(.headline)
            }
        }
        .navigationTitle("MLB Pitchers")
        .task {
            await viewModel.fetchPitchers(timeFrame: .L30)
        }
    }
}

#Preview {
    PitcherStatsView()
}
