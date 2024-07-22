//  HitterStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct HitterStatsView: View {
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
                Text("Minimum PA:")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                Picker("Select Minimum PAs", selection: $viewModel.minimumPA) {
                    ForEach(viewModel.PAs, id: \.self) { PA in
                        Text("\(PA)").tag(PA)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 250)
                .padding(.trailing)
            }
            Text("Number of Results: \(viewModel.hitters.count)")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
                .padding(.leading)
            if viewModel.isLoading {
                ProgressView("Updating...")
            }
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
        .navigationTitle("MLB Hitters")
        .task {
            await viewModel.fetchHitters(min: viewModel.minimumPA, timeFrame: viewModel.selectedTimeFrame)
        }
    }
}

#Preview {
    HitterStatsView()
}
