//  Catcher.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

struct Catcher: Identifiable, Decodable {
    let pos: String
    let G: Int
    let inn: Double
    let PO: Int
    let A: Int
    let E: Int
    let DP: Int
    let SB: Int?
    let CS: Int?
    let PB: Int?
    let WP: Int?
    let FP: Double
    let DRS: Int
    let def: Double?
    let FRM: Double?
    let FRV: Int?
    let name: String
    let id: Int
    let teamId: Int
    let teamName: String
    
    enum CodingKeys: String, CodingKey {
        case pos = "Pos"
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
        case def = "Defense"
        case FRM = "CFraming"
        case FRV = "FRP"
        case name = "PlayerName"
        case id = "xMLBAMID"
        case teamId = "teamid"
        case teamName = "TeamName"
    }
}

struct CatchersResponse: Decodable {
    let data: [Catcher]
}
