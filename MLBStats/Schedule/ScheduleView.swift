//  ScheduleView.swift
//  MLBStats
//  Created by Andrew Xin on 7/23/24.

import SwiftUI
import SDWebImageSwiftUI

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
                                VStack (alignment: .leading) {
                                    VStack {
                                        Text("\(mapTeamIdToAbbreviation(fromId: game.teams.away.team.id)) @ \(mapTeamIdToAbbreviation(fromId: game.teams.home.team.id))")
                                            .font(.headline)
                                        Text("\(game.gameDate.formattedGameTime())")
                                        HStack {
                                            Spacer()
                                            VStack {
                                                WebImage(url: URL(string: "https://www.mlbstatic.com/team-logos/\(game.teams.away.team.id).svg"))
                                                    .resizable()
                                                    .frame(width: 40, height: 40)
                                                Text("\(game.teams.away.leagueRecord.wins)-\(game.teams.away.leagueRecord.losses)")
                                                    .font(.caption)
                                            }
                                            Spacer()
                                            Text("@")
                                            Spacer()
                                            VStack {
                                                WebImage(url: URL(string: "https://www.mlbstatic.com/team-logos/\(game.teams.home.team.id).svg"))
                                                    .resizable()
                                                    .frame(width: 40, height: 40)
                                                Text("\(game.teams.home.leagueRecord.wins)-\(game.teams.home.leagueRecord.losses)")
                                                    .font(.caption)
                                            }
                                            Spacer()
                                        }
                                        Text("\(game.teams.away.score ?? 0) - \(game.teams.home.score ?? 0)")
                                            .font(.headline)
                                    }
                                    .padding(.bottom)
                                    Text("Venue: \(game.venue.name)")
                                    Text("Status: \(game.status.detailedState)")
                                    Text("Game ID: \(game.gamePk)")
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
