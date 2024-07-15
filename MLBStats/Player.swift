//  Player.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import Foundation

struct Player: Identifiable, Decodable {
    let id: Int
    let active: Bool?
    let batSide: Side?
    let birthCity: String?
    let birthCountry: String?
    let birthDate: String?
    let boxscoreName: String?
    let currentAge: Int?
    let currentTeam: Team?
    let firstLastName: String?
    let firstName: String?
    let fullFMLName: String?
    let fullLFMName: String?
    let fullName: String?
    let gender: String?
    let height: String?
    let initLastName: String?
    let isPlayer: Bool?
    let isVerified: Bool?
    let lastFirstName: String?
    let lastInitName: String?
    let lastName: String?
    let link: String?
    let middleName: String?
    let mlbDebutDate: String?
    let nameFirstLast: String?
    let nameSlug: String?
    let nickName: String?
    let pitchHand: Side?
    let primaryNumber: String?
    let primaryPosition: Position?
    // let pronunciation: String?
    let strikeZoneBottom: Double?
    let strikeZoneTop: Double?
    let useLastName: String?
    let useName: String?
    let weight: Int?

    struct Team: Decodable {
        let id: Int?
        let link: String?
        let name: String?
    }

    struct Position: Decodable {
        let abbreviation: String?
        let code: String?
        let name: String?
        let type: String?
    }

    struct Side: Decodable {
        let code: String?
        let description: String?
    }
}

struct PlayersResponse: Decodable {
    // let copyright: String?
    let people: [Player]?
}
