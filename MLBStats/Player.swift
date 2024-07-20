//  Player.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

struct Player: Hashable, Decodable {
    let playerid: Int
    let Name: String
}

struct PlayersResponse: Decodable {
    let data: [Player]
}
