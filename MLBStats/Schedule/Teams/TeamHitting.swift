//  TeamHitting.swift
//  MLBStats
//  Created by Andrew Xin on 7/28/24.

import Foundation

struct TeamHitting: Identifiable, Decodable {
    let G: Int                  // Games Played
    let AB: Int                 // At Bats
    let PA: Int                 // Plate Appearances
    let H: Int                  // Hits
    let singles: Int            // 1B
    let doubles: Int            // 2B
    let triples: Int            // 3B
    let HR: Int                 // Home Runs
    let R: Int                  // Runs
    let RBI: Int                // Runs Batted In
    let BB: Int                 // Walks
    let IBB: Int                // Intentional Walks
    let SO: Int                 // Strikeouts
    let HBP: Int                // Hit By Pitches
    let SF: Int                 // Sacrifice Flies
    let SH: Int                 // Sacrifice Hits
    let GDP: Int                // Grounded into Double Play
    let SB: Int                 // Stolen Bases
    let CS: Int                 // Caught Stealind
    let csPCT: Double?          // *Caught Stealing PCT*        - Calculated
    let AVG: Double             // Batting AVG
    let GB: Int                 // Ground Balls
    let FB: Int                 // Fly Balls
    let LD: Int                 // Line Drives
    let IFFB: Int               // Infield Fly Balls
    let pitches: Int            // 4968
    let balls: Int              // 2131
    let strikes: Int            // 2837
    let IFH: Int                // Infield Hits
    let BU: Int                 // Bunts
    let BUH: Int                // Bunt Hits
    let bbPCT: Double           // Walk PCT
    let kPCT: Double            // Strikeout PCT
    let BBperK: Double          // Walks/Strikeouts
    let OBP: Double             // On Base PCT
    let SLG: Double             // Slugging
    let OPS: Double             // On Base + Slugging
    let ISO: Double             // Isolated Power
    let BABIP: Double           // *Batting AVG on Balls in Play*
    let GBperFB: Double         // Ground Balls/Fly Balls
    let ldPCT: Double           // Line Drive PCT
    let gbPCT: Double           // Ground Ball PCT
    let fbPCT: Double           // Fly Ball PCT
    let iffpPCT: Double         // Infield Fly Ball PCT
    let HRperFB: Double         // Home Runs/Fly Balls
    let ifhPCT: Double          // Infield Hit PCT
    let buhPCT: Double          // Bunt Hit PCT
    let ttoPCT: Double          // Three Total Outcomes PCT
    // *Advanced Stats*
    let wOBA: Double            // Weighted On Base AVG
    let wRAA: Double            // Runs Above AVG
    let wRC: Double             // Runs Created
    let WAR: Double             // Wins Above Replacement
    // *Plus Stats*
    let wRCplus: Double         // Runs Created +
    let AVGplus: Double         // Batting AVG +
    let bbPCTplus: Double       // Walk PCT +
    let kPCTplus: Double        // Strikeout PCT +
    let OBPplus: Double         // On Base Percentage +
    let SLGplus: Double         // Slugging +
    let ISOplus: Double         // Isolated Power +
    let BABIPplus: Double       // Batting AVG on Balls in Play +
    let ldPCTplus: Double       // Line Drive PCT +
    let gbPCTplus: Double       // Ground Ball PCT +
    let fbPCTplus: Double       // Fly Ball PCT +
    let HRperFBpctPLUS: Double  // Home Runs/Fly Balls PCT +
    let id: Int                 // 9
    let name: String            // NYY
    
    enum CodingKeys: String, CodingKey {
        case G, AB, PA, H
        case singles = "1B"
        case doubles = "2B"
        case triples = "3B"
        case HR, R, RBI, BB, IBB, SO, HBP, SF, SH, GDP, SB, CS, AVG, GB, FB, LD, IFFB
        case pitches = "Pitches"
        case balls = "Balls"
        case strikes = "Strikes"
        case IFH, BU, BUH
        case bbPCT = "BB%"
        case kPCT = "K%"
        case BBperK = "BB/K"
        case OBP, SLG, OPS, ISO, BABIP
        case GBperFB = "GB/FB"
        case ldPCT = "LD%"
        case gbPCT = "GB%"
        case fbPCT = "FB%"
        case iffpPCT = "IFFB%"
        case HRperFB = "HR/FB"
        case ifhPCT = "IFH%"
        case buhPCT = "BUH%"
        case ttoPCT = "TTO%"
        case wOBA, wRAA, wRC, WAR
        case wRCplus = "wRC+"
        case AVGplus = "AVG+"
        case bbPCTplus = "BB%+"
        case kPCTplus = "K%+"
        case OBPplus = "OBP+"
        case SLGplus = "SLG+"
        case ISOplus = "ISO+"
        case BABIPplus = "BABIP+"
        case ldPCTplus = "LD%+"
        case gbPCTplus = "GB%+"
        case fbPCTplus = "FB%+"
        case HRperFBpctPLUS = "HRFB%+"
        case id = "teamid"
        case name = "TeamNameAbb"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        G = try container.decode(Int.self, forKey: .G)
        AB = try container.decode(Int.self, forKey: .AB)
        PA = try container.decode(Int.self, forKey: .PA)
        H = try container.decode(Int.self, forKey: .H)
        singles = try container.decode(Int.self, forKey: .singles)
        doubles = try container.decode(Int.self, forKey: .doubles)
        triples = try container.decode(Int.self, forKey: .triples)
        HR = try container.decode(Int.self, forKey: .HR)
        R = try container.decode(Int.self, forKey: .R)
        RBI = try container.decode(Int.self, forKey: .RBI)
        BB = try container.decode(Int.self, forKey: .BB)
        IBB = try container.decode(Int.self, forKey: .IBB)
        SO = try container.decode(Int.self, forKey: .SO)
        HBP = try container.decode(Int.self, forKey: .HBP)
        SF = try container.decode(Int.self, forKey: .SF)
        SH = try container.decode(Int.self, forKey: .SH)
        GDP = try container.decode(Int.self, forKey: .GDP)
        SB = try container.decode(Int.self, forKey: .SB)
        CS = try container.decode(Int.self, forKey: .CS)
        csPCT = Double(CS) / Double(SB + CS)
        AVG = try container.decode(Double.self, forKey: .AVG)
        GB = try container.decode(Int.self, forKey: .GB)
        FB = try container.decode(Int.self, forKey: .FB)
        LD = try container.decode(Int.self, forKey: .LD)
        IFFB = try container.decode(Int.self, forKey: .IFFB)
        pitches = try container.decode(Int.self, forKey: .pitches)
        balls = try container.decode(Int.self, forKey: .balls)
        strikes = try container.decode(Int.self, forKey: .strikes)
        IFH = try container.decode(Int.self, forKey: .IFH)
        BU = try container.decode(Int.self, forKey: .BU)
        BUH = try container.decode(Int.self, forKey: .BUH)
        bbPCT = try container.decode(Double.self, forKey: .bbPCT)
        kPCT = try container.decode(Double.self, forKey: .kPCT)
        BBperK = try container.decode(Double.self, forKey: .BBperK)
        OBP = try container.decode(Double.self, forKey: .OBP)
        SLG = try container.decode(Double.self, forKey: .SLG)
        OPS = try container.decode(Double.self, forKey: .OPS)
        ISO = try container.decode(Double.self, forKey: .ISO)
        BABIP = try container.decode(Double.self, forKey: .BABIP)
        GBperFB = try container.decode(Double.self, forKey: .GBperFB)
        ldPCT = try container.decode(Double.self, forKey: .ldPCT)
        gbPCT = try container.decode(Double.self, forKey: .gbPCT)
        fbPCT = try container.decode(Double.self, forKey: .fbPCT)
        iffpPCT = try container.decode(Double.self, forKey: .iffpPCT)
        HRperFB = try container.decode(Double.self, forKey: .HRperFB)
        ifhPCT = try container.decode(Double.self, forKey: .ifhPCT)
        buhPCT = try container.decode(Double.self, forKey: .buhPCT)
        ttoPCT = try container.decode(Double.self, forKey: .ttoPCT)
        wOBA = try container.decode(Double.self, forKey: .wOBA)
        wRAA = try container.decode(Double.self, forKey: .wRAA)
        wRC = try container.decode(Double.self, forKey: .wRC)
        WAR = try container.decode(Double.self, forKey: .WAR)
        wRCplus = try container.decode(Double.self, forKey: .wRCplus)
        AVGplus = try container.decode(Double.self, forKey: .AVGplus)
        bbPCTplus = try container.decode(Double.self, forKey: .bbPCTplus)
        kPCTplus = try container.decode(Double.self, forKey: .kPCTplus)
        OBPplus = try container.decode(Double.self, forKey: .OBPplus)
        SLGplus = try container.decode(Double.self, forKey: .SLGplus)
        ISOplus = try container.decode(Double.self, forKey: .ISOplus)
        BABIPplus = try container.decode(Double.self, forKey: .BABIPplus)
        ldPCTplus = try container.decode(Double.self, forKey: .ldPCTplus)
        gbPCTplus = try container.decode(Double.self, forKey: .gbPCTplus)
        fbPCTplus = try container.decode(Double.self, forKey: .fbPCTplus)
        HRperFBpctPLUS = try container.decode(Double.self, forKey: .HRperFBpctPLUS)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}

struct TeamHittingResponse: Decodable {
    let data: [TeamHitting]
}
