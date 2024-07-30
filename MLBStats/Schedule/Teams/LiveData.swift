//  LiveData.swift
//  MLBStats
//  Created by Andrew Xin on 7/30/24.

import Foundation

struct LiveData: Decodable {
    let boxscore: Boxscore
    
    struct Boxscore: Decodable {
        let teams: Teams
        
        struct Teams: Codable {
            let away: Team
            let home: Team
            
            struct Team: Codable {
                let batters: [Int]
                let pitchers: [Int]
                let bench: [Int]
                let bullpen: [Int]
                let battingOrder: [Int]
            }
        }
    }
}

struct LiveDataResponse: Decodable {
    let liveData: LiveData
}
