//  FielderStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct FielderStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            SeasonRangePicker(selectedSeasonRange: $viewModel.selectedSeasonRange)
            MinimumSelectionPicker(title: "Minimum IP", items: viewModel.IPs, selection: $viewModel.minimumIP)
            NumberOfResultsView(title: "Fielders", count: viewModel.fielders.count)
            if viewModel.isLoading {
                ProgressView("Updating...")
                Spacer()
            } else {
                List(viewModel.fielders) { fielder in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(fielder.name)
                                .font(.headline)
                            Text("(\(fielder.teamName))")
                        }
                        HStack {
                            Text("Pos: \(fielder.pos)")
                                .font(.caption)
                            Spacer()
                            Text("G: \(fielder.G)")
                                .font(.caption)
                        }
                        HStack {
                            Text("Innings Played: \(fielder.inn, specifier: "%.2f")")
                                .font(.caption)
                            Spacer()
                            Text("Putouts: \(fielder.PO)")
                                .font(.caption)
                        }
                        HStack {
                            Text("Assists: \(fielder.A)")
                                .font(.caption)
                            Spacer()
                            Text("Errors: \(fielder.E)")
                                .font(.caption)
                        }
                        
                        HStack {
                            Text("Double Plays: \(fielder.DP)")
                                .font(.caption)
                            Spacer()
                            Text("Fielding %: \(fielder.FP, specifier: "%.3f")")
                                .font(.caption)
                        }
                        HStack {
                            Text("Defensive Runs Saved: \(fielder.DRS)")
                                .font(.caption)
                            Spacer()
                            if let uzr = fielder.UZR {
                                Text("UZR: \(uzr, specifier: "%.2f")")
                                    .font(.caption)
                            }
                        }
                        HStack {
                            if let uzrPer150 = fielder.UZRper150 {
                                Text("UZR/150: \(uzrPer150, specifier: "%.2f")")
                                    .font(.caption)
                            }
                            Spacer()
                            if let def = fielder.DEF {
                                Text("DEF: \(def, specifier: "%.2f")")
                                    .font(.caption)
                            }
                        }
                        HStack {
                            if let oaa = fielder.OAA {
                                Text("OAA: \(oaa)")
                                    .font(.caption)
                            }
                            Spacer()
                            if let frv = fielder.FRV {
                                Text("Fielding Run Value: \(frv)")
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("MLB Fielders")
        .task {
            await viewModel.fetchFielders(startSeason: viewModel.selectedSeasonRange.startSeason)
        }
    }
}

#Preview {
    FielderStatsView()
}
