//  Fielder.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

struct Fielder: Identifiable, Decodable {
    let pos: String
    let G: Int
    let inn: Double
    let PO: Int
    let A: Int
    let E: Int
    let DP: Int
    let FP: Double
    let DRS: Int
    let UZR: Double?
    let UZR150: Double?
    let def: Double?
    let OAA: Int?
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
        case FP
        case DRS
        case UZR
        case UZR150 = "UZR/150"
        case def = "Defense"
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
