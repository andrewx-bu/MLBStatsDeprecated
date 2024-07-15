//  ContentView.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Button("Fetch Players") {
                viewModel.fetchPlayers()
            }
            
            List(viewModel.players) { player in
                VStack(alignment: .leading) {
                    Text(player.fullName)
                        .font(.headline)
                    Text("Position: \(player.primaryPosition.name)")
                    Text("Team ID: \(player.currentTeam.id)")
                    Text("Bats: \(player.batSide.description), Throws: \(player.pitchHand.description)")
                    Text("Slug: \(player.nameSlug)")
                    Text("Init Last Name: \(player.initLastName)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
