//  ContentView.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Button("Fetch Players") {
                viewModel.fetchPlayers()
            }
            .padding()
            
            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                List(viewModel.players) { player in
                    VStack(alignment: .leading) {
                        Text(player.fullName ?? "N/A")
                            .font(.headline)
                        Text("Team: \(player.currentTeam?.name ?? "N/A")")
                        Text("Position: \(player.primaryPosition?.name ?? "N/A")")
                        Text("Birth City: \(player.birthCity ?? "N/A")")
                        Text("Country: \(player.birthCountry ?? "N/A")")
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
