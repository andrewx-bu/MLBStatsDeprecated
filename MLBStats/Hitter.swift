//  Hitter.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

struct Hitter: Identifiable, Decodable {
    let batSide: String
    let id: Int
    let name: String
    let ageR: String
    let age: Int?
    
    enum CodingKeys: String, CodingKey {
        case batSide = "Bats"
        case id = "xMLBAMID"
        case name = "Name"
        case ageR = "AgeR"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        batSide = try container.decode(String.self, forKey: .batSide)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name).stripHTML()
        ageR = try container.decode(String.self, forKey: .ageR)
        age = ageR.extractMaxAge()
    }
}

struct HittersResponse: Decodable {
    let data: [Hitter]
}
