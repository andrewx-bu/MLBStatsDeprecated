//  Hitter.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

struct Hitter: Hashable, Decodable {
    let playerid: Int
    let Name: String
}

struct HittersResponse: Decodable {
    let data: [Hitter]
}
