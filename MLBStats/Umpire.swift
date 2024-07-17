//  Umpire.swift
//  MLBStats
//  Created by Andrew Xin on 7/17/24.

import Foundation

// Provided by 'jobs_umpires' endpoint
// Comments use Pat Hoberg as an example instance of an Umpire
struct Umpire: Decodable {
    let person: Person
    
    struct Person: Identifiable, Decodable {
        let id: Int                 // 573596
        let fullName: String        // "Pat Hoberg"
        let link: String            // "/api/v1/people/573596"
    }
}

struct UmpireResponse: Decodable {
    let roster: [Umpire]
}
