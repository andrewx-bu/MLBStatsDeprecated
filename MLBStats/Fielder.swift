//  Fielder.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

struct Fielder: Hashable, Decodable {
    let playerid: Int
    let Name: String
}

struct FieldersResponse: Decodable {
    let data: [Fielder]
}
