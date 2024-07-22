//  PitcherStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct PitcherStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Time Frame:")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                Picker("Select Time Frame", selection: $viewModel.selectedTimeFrame) {
                    ForEach(TimeFrame.allCases, id: \.self) { timeFrame in
                        Text(String(describing: timeFrame)).tag(timeFrame)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 250)
                .padding(.trailing)
            }
            HStack {
                Text("Minimum IP:")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                Picker("Select Minimum IP", selection: $viewModel.minimumIP) {
                    ForEach(viewModel.IPs, id: \.self) { IP in
                        Text("\(IP)").tag(IP)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 250)
                .padding(.trailing)
            }
            Text("Number of Results: \(viewModel.pitchers.count)")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
                .padding(.leading)
            if viewModel.isLoading {
                ProgressView("Updating...")
            }
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
        }
        .navigationTitle("MLB Pitchers")
        .task {
            await viewModel.fetchPitchers(min: viewModel.minimumIP, timeFrame: viewModel.selectedTimeFrame)
        }
    }
}

#Preview {
    PitcherStatsView()
}
