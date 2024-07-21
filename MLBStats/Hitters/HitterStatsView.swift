//  HitterStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct HitterStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        List(viewModel.hitters) { hitter in
            VStack(alignment: .leading) {
                HStack {
                    Text("\(hitter.name) (Bats: \(hitter.batSide))")
                        .font(.subheadline)
                    Spacer()
                    Text("Team: \(hitter.teamName)")
                        .font(.subheadline)
                }
                HStack {
                    Text("Age: \(hitter.age)")
                        .font(.caption)
                    Spacer()
                    Text("Position: \(hitter.pos)")
                        .font(.caption)
                }
            }
        }
        .navigationTitle("MLB Hitters")
        .task {
            await viewModel.fetchHitters(timeFrame: .SZN)
        }
    }
}

#Preview {
    HitterStatsView()
}
