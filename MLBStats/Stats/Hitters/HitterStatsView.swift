//  HitterStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct HitterStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            TimeFramePicker(selectedTimeFrame: $viewModel.selectedTimeFrame)
            MinimumSelectionPicker(title: "Minimum PA", items: viewModel.PAs, selection: $viewModel.minimumPA)
            NumberOfResultsView(title: "Hitters", count: viewModel.hitters.count)
            if viewModel.isLoading {
                ProgressView("Updating...")
                Spacer()
            } else {
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
            }
        }
        .navigationTitle("MLB Hitters")
        .task {
            await viewModel.fetchHitters(min: viewModel.minimumPA, timeFrame: viewModel.selectedTimeFrame)
        }
    }
}

#Preview {
    HitterStatsView()
}
