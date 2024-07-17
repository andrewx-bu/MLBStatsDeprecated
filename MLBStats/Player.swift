//  Player.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import Foundation

// Provided by 'sports_players' endpoint
// Comments use Shohei Ohtani as an example instance of Player
struct Player: Identifiable, Decodable {
    let id: Int                         // 660271
    let fullName: String                // "Shohei Ohtani"
    let link: String                    // "/api/v1/people/660271"
    let currentAge: Int                 // 30
    let currentTeam: Team
    let primaryPosition: Position
    let mlbDebutDate: String            // "2018-03-29"
    let batSide: BatSide
    let pitchHand: PitchHand
    let initLastName: String            // "S Ohtani"
    
    struct Team: Decodable {
        let id: Int                     // 119
        let link: String                // "/api/v1/teams/119"
    }
    
    struct Position: Codable {
        let code: String                // "Y"
        let abbreviation: String        // "TWP"
    }
    
    struct BatSide: Codable {
        let code: String                // "L"
    }
    
    struct PitchHand: Codable {
        let code: String                // "R"
    }
}

struct PlayerResponse: Decodable {
    let people: [Player]
}
