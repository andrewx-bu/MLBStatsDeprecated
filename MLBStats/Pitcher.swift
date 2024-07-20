//  Pitcher.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

struct Pitcher: Hashable, Decodable {
    let playerid: Int
    let Name: String
}

struct PitchersResponse: Decodable {
    let data: [Pitcher]
}
