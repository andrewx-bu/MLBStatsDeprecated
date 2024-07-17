//  ContentView.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.teams) { team in
                    Section(header: Text(team.name)) {
                        Text("Venue: \(team.venue.name)")
                        Text("Abbreviation: \(team.abbreviation)")
                        Text("League: \(team.league.name)")
                        Text("Short Name: \(team.shortName)")
                        
                        ForEach(viewModel.players.filter { $0.currentTeam.id == team.id }) { player in
                            VStack(alignment: .leading) {
                                Text("Name: \(player.fullName)")
                                Text("Current Age: \(player.currentAge)")
                                Text("Position: \(player.primaryPosition.code)")
                                Text("Bats: \(player.batSide.code)")
                                Text("Pitches: \(player.pitchHand.code)")
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("MLB Teams and Players")
            .onAppear {
                viewModel.fetchAllData()
            }
        }
    }
}

#Preview {
    ContentView()
}
