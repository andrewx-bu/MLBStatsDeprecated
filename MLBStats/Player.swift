//  Player.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import Foundation

struct Player: Identifiable, Decodable {
    let id: Int
    let fullName: String
    let link: String
    let primaryNumber: String
    let currentAge: Int
    let currentTeam: Team
    let primaryPosition: Position
    let batSide: BatSide
    let pitchHand: PitchHand
    let nameSlug: String
    let initLastName: String
    let strikeZoneTop: Double
    let strikeZoneBottom: Double
    
    struct Team: Decodable {
        let id: Int
        let link: String
    }
    
    struct Position: Codable {
        let code: String
        let name: String
        let type: String
        let abbreviation: String
    }
    
    struct BatSide: Codable {
        let code: String
        let description: String
    }
    
    struct PitchHand: Codable {
        let code: String
        let description: String
    }
}

struct PlayerResponse: Decodable {
    // let copyright: String
    let people: [Player]
}
