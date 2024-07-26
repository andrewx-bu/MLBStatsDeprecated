//  ScheduleView.swift
//  MLBStats
//  Created by Andrew Xin on 7/23/24.

import SwiftUI

struct ScheduleView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("Select Date:", selection: $viewModel.selectedDate, displayedComponents: [.date])
                    .frame(width: 250)
                    .padding(.horizontal)
                List(viewModel.schedule, id: \.date) { scheduleDate in
                    Section(header: Text("Date: \(scheduleDate.date)")) {
                        ForEach(scheduleDate.games, id: \.gamePk) { game in
                            NavigationLink(destination: ScheduleDetailView(game: game)) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("\(game.teams.away.team.name) @ \(game.teams.home.team.name)")
                                            .font(.headline)
                                        Spacer()
                                        Text("\(game.teams.away.score ?? 0)-\(game.teams.home.score ?? 0)")
                                            .font(.headline)
                                    }
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Away Team Record:")
                                                .font(.subheadline)
                                            Text("\(game.teams.away.leagueRecord.wins)-\(game.teams.away.leagueRecord.losses)")
                                                .font(.caption)
                                        }
                                        Spacer()
                                        VStack(alignment: .leading) {
                                            Text("Home Team Record:")
                                                .font(.subheadline)
                                            Text("\(game.teams.home.leagueRecord.wins)-\(game.teams.home.leagueRecord.losses)")
                                                .font(.caption)
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
            }
            .navigationTitle("Schedule")
            .task {
                await viewModel.fetchSchedule(date: viewModel.selectedDate)
            }
        }
    }
}

#Preview {
    ScheduleView()
}
