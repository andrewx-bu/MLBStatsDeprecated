//  Player.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

struct Player: Identifiable, Decodable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "xMLBAMID"
        case name = "PlayerName"
    }
}

struct PlayersResponse: Decodable {
    let data: [Player]
}
