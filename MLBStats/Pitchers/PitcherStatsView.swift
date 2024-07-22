//  PitcherStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct PitcherStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("Choose Time Frame:")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .font(.subheadline)
            // L30 Does Not Work ATM
            Picker("Select Time Frame", selection: $viewModel.selectedTimeFrame) {
                ForEach(TimeFrame.allCases, id: \.self) { timeFrame in
                    Text(String(describing: timeFrame)).tag(timeFrame)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
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
                await viewModel.fetchPitchers(timeFrame: viewModel.selectedTimeFrame)
            }
        }
    }
}

#Preview {
    PitcherStatsView()
}
