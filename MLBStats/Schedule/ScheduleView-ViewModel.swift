//  ScheduleView-ViewModel.swift
//  MLBStats
//  Created by Andrew Xin on 7/23/24.

import Foundation

extension ScheduleView {
    @Observable class ViewModel {
        var schedule: [ScheduleDate] = []
        var selectedDate: Date = Date() {
            didSet {
                Task {
                    await fetchSchedule(date: selectedDate)
                }
            }
        }
        
        /*
         By default, fetches games for this day. Will refresh at 6:00 AM PST I believe
         - Allows fetching games for a specific day: Date format is MM/DD/YYYY
         */
        func fetchSchedule(date: Date? = nil) async {
            var urlString = "https://statsapi.mlb.com/api/v1/schedule?sportId=1"
            if let date = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let dateString = dateFormatter.string(from: date)
                urlString += "&date=\(dateString)"
            }
            guard let url = URL(string: urlString) else {
                print("Invalid schedule URL")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(ScheduleResponse.self, from: data)
                self.schedule = response.dates
            } catch {
                print("Error fetching or decoding schedule JSON: \(error.localizedDescription)")
            }
        }
    }
}
