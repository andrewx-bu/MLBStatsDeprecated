//  ContentView.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.players, id: \.self) { player in
                VStack(alignment: .leading) {
                    Text(player.Name)
                        .font(.headline)
                }
            }
            .navigationTitle("MLB Players")
            .onAppear {
                viewModel.fetchPlayers(timeFrame: ContentView.ViewModel.TimeFrame.L30)
            }
        }
    }
}

#Preview {
    ContentView()
}
