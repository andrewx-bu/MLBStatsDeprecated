//  Fielder.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

struct Fielder: Identifiable, Decodable {
    let pos: String         // Position
    let G: Int              // Games Played
    let inn: Double         // Innings Played
    let PO: Int             // Putouts
    let A: Int              // Assists
    let E: Int              // Errors
    let DP: Int             // Double Plays? This stat seems off
    let FP: Double          // *Fielding PCT*
    let DRS: Int            // *Defensive Runs Saved*
    let UZR: Double?        // *Ultimate Zone Rating*
    let UZRper150: Double?  // *UZR per 150 Games*              - FanGraphs
    let DEF: Double?        // *Defensive Runs Above AVG*       - FanGraphs
    let OAA: Int?           // *Outs Above AVG*                 - Statcast
    let FRV: Int?           // *Fielding Run Value*             - Statcast
    let name: String        // Bobby Witt Jr.
    let id: Int             // 677951
    let teamId: Int         // 7
    let teamName: String    // KCR
    
    enum CodingKeys: String, CodingKey {
        case pos = "Pos"
        case G
        case inn = "Inn"
        case PO
        case A
        case E
        case DP
        case FP
        case DRS
        case UZR
        case UZRper150 = "UZR/150"
        case DEF = "Defense"
        case OAA
        case FRV = "FRP"
        case name = "PlayerName"
        case id = "xMLBAMID"
        case teamId = "teamid"
        case teamName = "TeamName"
    }
}

struct FieldersResponse: Decodable {
    let data: [Fielder]
}
