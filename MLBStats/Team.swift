//  Team.swift
//  MLBStats
//  Created by Andrew Xin on 7/15/24.

import Foundation

// Provided by 'teams' endpoint
// Comments use Los Angeles Dodgers as an example instance of Team
struct Team: Identifiable, Decodable {
    let id: Int                     // 119
    let name: String                // Los Angeles Dodgers
    let link: String                // "/api/v1/teams/119"
    let venue: Venue
    let abbreviation: String        // "LAD"
    let league: League
    let shortName: String           // LA Dodgers
    
    struct Venue: Decodable {
        let id: Int                 // 22
        let name: String            // "Dodger Stadium"
        let link: String            // "/api/v1/venues/22"
    }
    
    struct League: Decodable {
        let id: Int                 // 104
        let name: String            // "National League"
        let link: String            // "/api/v1/league/104"
    }
}

struct TeamResponse: Decodable {
    let teams: [Team]
}
