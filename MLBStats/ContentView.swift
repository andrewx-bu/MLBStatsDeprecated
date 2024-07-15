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
                        Text("Season: \(team.season)")
                        Text("Venue: \(team.venue.name)")
                        Text("Abbreviation: \(team.abbreviation)")
                        Text("League: \(team.league.name)")
                        Text("Division: \(team.division.name)")
                        Text("Short Name: \(team.shortName)")
                        
                        ForEach(viewModel.players.filter { $0.currentTeam.id == team.id }) { player in
                            VStack(alignment: .leading) {
                                Text("Name: \(player.fullName)")
                                Text("Primary Number: \(player.primaryNumber)")
                                Text("Current Age: \(player.currentAge)")
                                Text("Position: \(player.primaryPosition.name)")
                                Text("Bats: \(player.batSide.description)")
                                Text("Pitches: \(player.pitchHand.description)")
                                Text("Strike Zone Top: \(player.strikeZoneTop)")
                                Text("Strike Zone Bottom: \(player.strikeZoneBottom)")
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("MLB Teams and Players")
            .onAppear {
                viewModel.fetchData()
            }
        }
    }
}

#Preview {
    ContentView()
}
