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
                        Text(hitter.name)
                            .font(.headline)
                    }
                }
                .navigationTitle("MLB Hitters")
                .onAppear {
                    viewModel.fetchHitters(timeFrame: .L30)
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
                    viewModel.fetchPitchers(timeFrame: .L2Y)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
