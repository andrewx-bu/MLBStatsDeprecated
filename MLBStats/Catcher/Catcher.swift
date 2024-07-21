//  Catcher.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

struct Catcher: Identifiable, Decodable {
    let G: Int              // Games Played
    let inn: Double         // Innings Played
    let PO: Int             // Putouts
    let A: Int              // Assists
    let E: Int              // Errors
    let DP: Int             // Double Plays? This stat seems off
    let SB: Int             // Stolen Bases
    let CS: Int             // Caught Stealing
    let csPCT: Double?      // *Caught Stealing PCT*            - Calculated
    let PB: Int             // *Passed Balls*
    let WP: Int             // Wild Pitches
    let FP: Double          // *Fielding PCT*
    let DRS: Int            // *Defensive Runs Saved*
    let DEF: Double         // *Defensive Runs Above AVG*       - FanGraphs
    let FRM: Double         // Catcher Framing                  - Statcast
    let FRV: Int            // *Fielding Run Value*             - Statcast
    let name: String        // Patrick Bailey
    let id: Int             // 672275
    let teamId: Int         // 30
    let teamName: String    // SFG
    
    enum CodingKeys: String, CodingKey {
        case G
        case inn = "Inn"
        case PO
        case A
        case E
        case DP
        case SB
        case CS
        case PB
        case WP
        case FP
        case DRS
        case DEF = "Defense"
        case FRM = "CFraming"
        case FRV = "FRP"
        case name = "PlayerName"
        case id = "xMLBAMID"
        case teamId = "teamid"
        case teamName = "TeamName"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        G = try container.decode(Int.self, forKey: .G)
        inn = try container.decode(Double.self, forKey: .inn)
        PO = try container.decode(Int.self, forKey: .PO)
        A = try container.decode(Int.self, forKey: .A)
        E = try container.decode(Int.self, forKey: .E)
        DP = try container.decode(Int.self, forKey: .DP)
        SB = try container.decode(Int.self, forKey: .SB)
        CS = try container.decode(Int.self, forKey: .CS)
        csPCT = Double(CS) / Double(SB + CS)
        PB = try container.decode(Int.self, forKey: .PB)
        WP = try container.decode(Int.self, forKey: .WP)
        FP = try container.decode(Double.self, forKey: .FP)
        DRS = try container.decode(Int.self, forKey: .DRS)
        DEF = try container.decode(Double.self, forKey: .DEF)
        FRM = try container.decode(Double.self, forKey: .FRM)
        FRV = try container.decode(Int.self, forKey: .FRV)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        teamId = try container.decode(Int.self, forKey: .teamId)
        teamName = try container.decode(String.self, forKey: .teamName)
    }
}

struct CatchersResponse: Decodable {
    let data: [Catcher]
}
