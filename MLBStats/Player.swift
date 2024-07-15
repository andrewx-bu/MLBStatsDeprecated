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
    let primaryNumber: String           // "17"
    let currentAge: Int                 // 30
    let currentTeam: Team
    let primaryPosition: Position
    let batSide: BatSide
    let pitchHand: PitchHand
    let initLastName: String            // "S Ohtani"
    let strikeZoneTop: Double           // 3.46
    let strikeZoneBottom: Double        // 1.56
    
    struct Team: Decodable {
        let id: Int                     // 119
        let link: String                // "/api/v1/teams/119"
    }
    
    struct Position: Codable {
        let code: String                // "Y"
        let name: String                // "Two-Way Player"
        let type: String                // "Two-Way Player"
        let abbreviation: String        // "TWP"
    }
    
    struct BatSide: Codable {
        let code: String                // "L"
        let description: String         // "Left
    }
    
    struct PitchHand: Codable {
        let code: String                // "R"
        let description: String         // "Right"
    }
}

struct PlayerResponse: Decodable {
    let people: [Player]
}
