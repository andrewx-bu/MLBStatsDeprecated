//  HitterStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct HitterStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        List(viewModel.hitters) { hitter in
            VStack(alignment: .leading) {
                Text("\(hitter.name) (Bats: \(hitter.bats))")
                    .font(.headline)
                Text("Age: \(hitter.age ?? 0)")
                    .font(.caption)
            }
        }
        .navigationTitle("MLB Hitters")
        .task {
            await viewModel.fetchHitters(timeFrame: .L30)
        }
    }
}

#Preview {
    HitterStatsView()
}
