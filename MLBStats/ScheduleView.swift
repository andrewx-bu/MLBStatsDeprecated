//  ScheduleView.swift
//  MLBStats
//  Created by Andrew Xin on 7/23/24.

import SwiftUI

struct ScheduleView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            DatePicker("Select Date:", selection: $viewModel.selectedDate, displayedComponents: [.date])
                .frame(width: 250)
                .padding(.horizontal)
            if viewModel.isLoading {
                ProgressView("Updating...")
                Spacer()
            }
            List(viewModel.schedule, id: \.date) { scheduleDate in
                Section(header: Text("Date: \(scheduleDate.date)")) {
                    ForEach(scheduleDate.games, id: \.gamePk) { game in
                        VStack(alignment: .leading) {
                            Text("Game ID: \(game.gamePk)")
                                .font(.headline)
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Away Team: \(game.teams.away.team.name)")
                                    Text("Score: \(game.teams.away.score ?? 0)")
                                    Text("Record: \(game.teams.away.leagueRecord.wins)-\(game.teams.away.leagueRecord.losses)")
                                }
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("Home Team: \(game.teams.home.team.name)")
                                    Text("Score: \(game.teams.home.score ?? 0)")
                                    Text("Record: \(game.teams.home.leagueRecord.wins)-\(game.teams.home.leagueRecord.losses)")
                                }
                            }
                            
                            Text("Venue: \(game.venue.name)")
                            Text("Date: \(game.gameDate.formattedGameDate())")
                            Text("Status: \(game.status.statusCode)")
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.fetchSchedule(date: viewModel.selectedDate)
        }
    }
    
    
}

#Preview {
    ScheduleView()
}
