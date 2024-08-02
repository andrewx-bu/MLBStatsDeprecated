//  PitcherStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct PitcherStatsView: View {
    @State private var viewModel = StatsViewModel()
    
    var body: some View {
        VStack {
            TimeFramePicker(selectedTimeFrame: $viewModel.selectedTimeFrame)
            MinimumSelectionPicker(title: "Minimum IP", items: viewModel.IPs, selection: $viewModel.minimumIP)
            NumberOfResultsView(title: "Pitchers", count: viewModel.pitchers.count)
            if viewModel.isLoading {
                ProgressView("Updating...")
                Spacer()
            } else {
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
                        HStack {
                            Text("FIP: \(pitcher.FIP, specifier: "%.2f")")
                                .font(.caption)
                            Spacer()
                            Text("xFIP: \(pitcher.xFIP, specifier: "%.2f")")
                                .font(.caption)
                        }
                        HStack {
                            Text("tERA: \(pitcher.tERA, specifier: "%.2f")")
                                .font(.caption)
                            Spacer()
                            Text("WAR: \(pitcher.WAR, specifier: "%.1f")")
                                .font(.caption)
                        }
                        HStack {
                            Text("ERA-: \(pitcher.ERAminus, specifier: "%.1f")")
                                .font(.caption)
                            Spacer()
                            Text("FIP-: \(pitcher.FIPminus, specifier: "%.1f")")
                                .font(.caption)
                        }
                        HStack {
                            Text("xFIP-: \(pitcher.xFIPminus, specifier: "%.1f")")
                                .font(.caption)
                            Spacer()
                            Text("K/9+: \(pitcher.Kper9plus, specifier: "%.1f")")
                                .font(.caption)
                        }
                        HStack {
                            Text("BB/9+: \(pitcher.BBper9plus, specifier: "%.1f")")
                                .font(.caption)
                            Spacer()
                            Text("K/BB+: \(pitcher.KperBBplus, specifier: "%.1f")")
                                .font(.caption)
                        }
                        HStack {
                            Text("H/9+: \(pitcher.Hper9plus, specifier: "%.1f")")
                                .font(.caption)
                            Spacer()
                            Text("HR/9+: \(pitcher.HRper9plus, specifier: "%.1f")")
                                .font(.caption)
                        }
                        HStack {
                            Text("AVG+: \(pitcher.AVGplus, specifier: "%.1f")")
                                .font(.caption)
                            Spacer()
                            Text("WHIP+: \(pitcher.WHIPplus, specifier: "%.1f")")
                                .font(.caption)
                        }
                        HStack {
                            Text("BABIP+: \(pitcher.BABIPplus, specifier: "%.3f")")
                                .font(.caption)
                            Spacer()
                            Text("LOB%+: \(pitcher.lobPCTplus, specifier: "%.1f")")
                                .font(.caption)
                        }
                        HStack {
                            Text("K%+: \(pitcher.kPCTplus, specifier: "%.1f")")
                                .font(.caption)
                            Spacer()
                            Text("BB%+: \(pitcher.bbPCTplus, specifier: "%.1f")")
                                .font(.caption)
                        }
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
