//  HitterStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct HitterStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("Choose Time Frame:")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .font(.subheadline)
            Picker("Select Time Frame", selection: $viewModel.selectedTimeFrame) {
                ForEach(TimeFrame.allCases, id: \.self) { timeFrame in
                    Text(String(describing: timeFrame)).tag(timeFrame)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
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
            .navigationTitle("MLB Hitter Stats")
            .task {
                await viewModel.fetchHitters(timeFrame: viewModel.selectedTimeFrame)
            }
        }
    }
}

#Preview {
    HitterStatsView()
}
