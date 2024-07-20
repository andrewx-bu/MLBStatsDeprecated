//  ContentView.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            if true {
                List(viewModel.hitters) { hitter in
                    VStack(alignment: .leading) {
                        Text("\(hitter.name) (\(hitter.age ?? 0))")
                            .font(.headline)
                        Text("bats: \(hitter.batSide)")
                            .font(.caption)
                        Text("id: " + String(hitter.id))
                            .font(.caption)
                    }
                }
                .navigationTitle("MLB Hitters")
                .onAppear {
                    viewModel.fetchHitters(PA: 25, timeFrame: .L30)
                }
            } else {
                List(viewModel.pitchers, id: \.self) { pitcher in
                    VStack(alignment: .leading) {
                        Text(pitcher.Name)
                            .font(.headline)
                    }
                }
                .navigationTitle("MLB Pitchers")
                .onAppear {
                    viewModel.fetchPitchers(IP: 25, timeFrame: .L2Y)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
