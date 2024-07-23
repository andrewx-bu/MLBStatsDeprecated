//  Extensions.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

extension String {
    // Extracts the higher bound from an age range string like "30 - 32".
    func extractMaxAge() -> Int {
        let components = self.split(separator: " - ")
        if components.count == 2, let highBound = Int(components[1]) {
            return highBound
        }
        return 0
    }
    
    // Formats a date like: "2024-07-08T16:35:00Z
    func formattedGameDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MMMM d, yyyy h:mm a"
            return dateFormatter.string(from: date)
        }
        return self
    }
}
