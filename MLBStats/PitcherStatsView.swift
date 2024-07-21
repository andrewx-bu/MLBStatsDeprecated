//  PitcherStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct PitcherStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(1.5, anchor: .center)
                .padding()
        } else {
            List(viewModel.pitchers, id: \.self) { pitcher in
                VStack(alignment: .leading) {
                    Text(pitcher.Name)
                        .font(.headline)
                }
            }
            .navigationTitle("MLB Pitchers")
            .task {
                await viewModel.fetchPitchers(IP: 10, timeFrame: .L30)
            }
        }
    }
}

#Preview {
    PitcherStatsView()
}
