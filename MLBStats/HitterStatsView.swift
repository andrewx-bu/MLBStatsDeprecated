//  HitterStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct HitterStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        List(viewModel.hitters) { hitter in
            VStack(alignment: .leading) {
                Text("\(hitter.name) (\(hitter.age ?? 0))")
                    .font(.headline)
                Text("Bats: \(hitter.batSide)")
                    .font(.caption)
                Text("ID: " + String(hitter.id))
                    .font(.caption)
            }
        }
        .navigationTitle("MLB Hitters")
        .task {
            await viewModel.fetchHitters(PA: 25, timeFrame: .L30)
        }
    }
}

#Preview {
    HitterStatsView()
}
