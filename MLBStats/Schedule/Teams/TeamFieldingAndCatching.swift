//  TeamFieldingAndCatching.swift
//  MLBStats
//  Created by Andrew Xin on 7/23/24.

import Foundation

struct TeamFieldingAndCatching: Identifiable, Decodable {
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
    let UZR: Double         // *Ultimate Zone Rating*
    let UZRper150: Double   // *UZR per 150 Games*              - FanGraphs
    let DEF: Double         // *Defensive Runs Above AVG*       - FanGraphs
    let FRM: Double         // Catcher Framing                  - Statcast
    let OAA: Int            // *Outs Above AVG*                 - Statcast
    let FRV: Int            // *Fielding Run Value*             - Statcast
    let id: Int             // 7
    let name: String        // KCR
    
    enum CodingKeys: String, CodingKey {
        case G
        case inn = "Inn"
        case PO, A, E, DP, SB, CS, PB, WP, FP, DRS, UZR
        case UZRper150 = "UZR/150"
        case DEF = "Defense"
        case FRM = "CFraming"
        case OAA
        case FRV = "FRP"
        case id = "teamid"
        case name = "TeamNameAbb"
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
        UZR = try container.decode(Double.self, forKey: .UZR)
        UZRper150 = try container.decode(Double.self, forKey: .UZRper150)
        DEF = try container.decode(Double.self, forKey: .DEF)
        FRM = try container.decode(Double.self, forKey: .FRM)
        OAA = try container.decode(Int.self, forKey: .OAA)
        FRV = try container.decode(Int.self, forKey: .FRV)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}

struct TeamFieldingAndCatchingResponse: Decodable {
    let data: [TeamFieldingAndCatching]
}
