//  TeamPitching.swift
//  MLBStats
//  Created by Andrew Xin on 7/28/24.

import Foundation

struct TeamPitching: Identifiable, Decodable {
    let W: Int                  // Wins
    let L: Int                  // Losses
    let ERA: Double             // Earned Runs AVG
    let G: Int                  // Games Played
    let GS: Int                 // Games Started
    let QS: Int                 // Quality Starts
    let SV: Int                 // Saves
    let HLD: Int                // Holds
    let BS: Int                 // Blown Saves
    let IP: Double              // Innings Pitched
    let TBF: Int                // Total Batters Faced
    let H: Int                  // Hits
    let R: Int                  // Runs
    let ER: Int                 // Earned Runs
    let HR: Int                 // Home Runs
    let BB: Int                 // Walks
    let IBB: Int                // Intentional Walks
    let HBP: Int                // Hit By Pitches
    let WP: Int                 // Wild Pitches
    let BK: Int                 // Balks
    let SO: Int                 // Strikeouts
    let Kper9: Double           // Strikeouts/9 Innings
    let BBper9: Double          // Walks/9 Innings
    let Hper9: Double           // Hits/9 Innings
    let KperBB: Double          // Strikeouts/Walks
    let ifhPCT: Double          // Infield Hit PCT
    let buhPCT: Double          // Bunt Hit PCT
    let ttoPCT: Double          // Three Total Outcomes PCT
    let GB: Int                 // Ground Balls
    let FB: Int                 // Fly Balls
    let LD: Int                 // Line Drives
    let IFFB: Int               // Infield Fly Balls
    let IFH: Int                // Infield Hits
    let BU: Int                 // Bunts
    let BUH: Int                // Bunt Hits
    let kPCT: Double            // Strikeout PCT
    let bbPCT: Double           // Walk PCT
    let kMINUSbbPCT: Double     // Strikeout PCT - Walk PCT
    let SIERA: Double           // Skill Interactive ERA
    let HRper9: Double          // Home Runs/9 Innings
    let AVG: Double             // Batting AVG
    let WHIP: Double            // Walks and Hits per Inning Pitched
    let BABIP: Double           // *Batting AVG on Balls in Play*
    let lobPCT: Double          // Left on Base PCT
    let FIP: Double             // Fielding Independent Pitching
    let kwERA: Double           // Earned Run AVG on Strikeouts and Walks       - FanGraphs
    let xFIP: Double            // Expected Fielding Independent Pitching
    // *Minus Stats*
    let ERAminus: Double        // Earned Runs AVG -                            - FanGraphs
    let FIPminus: Double        // Field Independent Pitching -                 - Fangraphs
    let xFIPminus: Double       // Expected Field Independent Pitching -        - Fangraphs
    let GBperFB: Double         // Ground Balls/Fly Balls
    let ldPCT: Double           // Line Drive PCT
    let gbPCT: Double           // Ground Ball PCT
    let fbPCT: Double           // Fly Ball PCT
    let iffbPCT: Double         // Infield Fly Ball PCT
    let HRperFB: Double         // Home Run/Fly Ball
    let RS: Int                 // Run Support
    let RSper9: Double          // Run Support/9 Innings
    let balls: Int              // 2940
    let strikes: Int            // 5739
    let pitches: Int            // 8679
    
    let name: String            // NYY
    let id: Int                 // 9
    
    let tERA: Double            // *True Earned Run AVG*
    let WAR: Double             // *Wins Above Replacement*
    // *Plus Stats*
    let Kper9plus: Double       // Strikeout/9 Innings +
    let BBper9plus: Double      // Walks/9 Innings +
    let KperBBplus: Double      // Strikeouts/Walks +
    let Hper9plus: Double       // Hits/9 Innings +
    let HRper9plus: Double      // HR/9 Innings +
    let AVGplus: Double         // Batting AVG +
    let WHIPplus: Double        // Walks and Hits per Inning Pitched +
    let BABIPplus: Double       // Batting AVG on Balls in Play +
    let lobPCTplus: Double      // Left on Base PCT +
    let kPCTplus: Double        // Strikeout PCT +
    let bbPCTplus: Double       // Walk PCT +
    let ldPCTplus: Double       // Line Drive PCT +
    let gbPCTplus: Double       // Ground Ball PCT +
    let fbPCTplus: Double       // Fly Ball PCT +
    let HRperFBpctPLUS: Double  // Home Runs/Fly Balls PCT +
    
    enum CodingKeys: String, CodingKey {
        case W, L, ERA, G, GS, QS, SV, HLD, BS, IP, TBF, H, R, ER, HR, BB, IBB, HBP, WP, BK, SO
        case Kper9 = "K/9"
        case BBper9 = "BB/9"
        case Hper9 = "H/9"
        case KperBB = "K/BB"
        case ifhPCT = "IFH%"
        case buhPCT = "BUH%"
        case ttoPCT = "TTO%"
        case GB, FB, LD, IFFB, IFH, BU, BUH
        case kPCT = "K%"
        case bbPCT = "BB%"
        case kMINUSbbPCT = "K-BB%"
        case SIERA
        case HRper9 = "HR/9"
        case AVG, WHIP, BABIP
        case lobPCT = "LOB%"
        case FIP, kwERA, xFIP
        case ERAminus = "ERA-"
        case FIPminus = "FIP-"
        case xFIPminus = "xFIP-"
        case GBperFB = "GB/FB"
        case ldPCT = "LD%"
        case gbPCT = "GB%"
        case fbPCT = "FB%"
        case iffbPCT = "IFFB%"
        case HRperFB = "HR/FB"
        case RS
        case RSper9 = "RS/9"
        case balls = "Balls"
        case strikes = "Strikes"
        case pitches = "Pitches"
        case name = "TeamNameAbb"
        case id = "teamid"
        case tERA, WAR
        // *Plus Stats*
        case Kper9plus = "K/9+"
        case BBper9plus = "BB/9+"
        case KperBBplus = "K/BB+"
        case Hper9plus = "H/9+"
        case HRper9plus = "HR/9+"
        case AVGplus = "AVG+"
        case WHIPplus = "WHIP+"
        case BABIPplus = "BABIP+"
        case lobPCTplus = "LOB%+"
        case kPCTplus = "K%+"
        case bbPCTplus = "BB%+"
        case ldPCTplus = "LD%+"
        case gbPCTplus = "GB%+"
        case fbPCTplus = "FB%+"
        case HRperFBpctPLUS = "HRFB%+"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        W = try container.decode(Int.self, forKey: .W)
        L = try container.decode(Int.self, forKey: .L)
        ERA = try container.decode(Double.self, forKey: .ERA)
        G = try container.decode(Int.self, forKey: .G)
        GS = try container.decode(Int.self, forKey: .GS)
        QS = try container.decode(Int.self, forKey: .QS)
        SV = try container.decode(Int.self, forKey: .SV)
        HLD = try container.decode(Int.self, forKey: .HLD)
        BS = try container.decode(Int.self, forKey: .BS)
        IP = try container.decode(Double.self, forKey: .IP)
        TBF = try container.decode(Int.self, forKey: .TBF)
        H = try container.decode(Int.self, forKey: .H)
        R = try container.decode(Int.self, forKey: .R)
        ER = try container.decode(Int.self, forKey: .ER)
        HR = try container.decode(Int.self, forKey: .HR)
        BB = try container.decode(Int.self, forKey: .BB)
        IBB = try container.decode(Int.self, forKey: .IBB)
        HBP = try container.decode(Int.self, forKey: .HBP)
        WP = try container.decode(Int.self, forKey: .WP)
        BK = try container.decode(Int.self, forKey: .BK)
        SO = try container.decode(Int.self, forKey: .SO)
        Kper9 = try container.decode(Double.self, forKey: .Kper9)
        BBper9 = try container.decode(Double.self, forKey: .BBper9)
        Hper9 = try container.decode(Double.self, forKey: .Hper9)
        KperBB = try container.decode(Double.self, forKey: .KperBB)
        ifhPCT = try container.decode(Double.self, forKey: .ifhPCT)
        buhPCT = try container.decode(Double.self, forKey: .buhPCT)
        ttoPCT = try container.decode(Double.self, forKey: .ttoPCT)
        GB = try container.decode(Int.self, forKey: .GB)
        FB = try container.decode(Int.self, forKey: .FB)
        LD = try container.decode(Int.self, forKey: .LD)
        IFFB = try container.decode(Int.self, forKey: .IFFB)
        IFH = try container.decode(Int.self, forKey: .IFH)
        BU = try container.decode(Int.self, forKey: .BU)
        BUH = try container.decode(Int.self, forKey: .BUH)
        kPCT = try container.decode(Double.self, forKey: .kPCT)
        bbPCT = try container.decode(Double.self, forKey: .bbPCT)
        kMINUSbbPCT = try container.decode(Double.self, forKey: .kMINUSbbPCT)
        SIERA = try container.decode(Double.self, forKey: .SIERA)
        HRper9 = try container.decode(Double.self, forKey: .HRper9)
        AVG = try container.decode(Double.self, forKey: .AVG)
        WHIP = try container.decode(Double.self, forKey: .WHIP)
        BABIP = try container.decode(Double.self, forKey: .BABIP)
        lobPCT = try container.decode(Double.self, forKey: .lobPCT)
        FIP = try container.decode(Double.self, forKey: .FIP)
        kwERA = try container.decode(Double.self, forKey: .kwERA)
        xFIP = try container.decode(Double.self, forKey: .xFIP)
        ERAminus = try container.decode(Double.self, forKey: .ERAminus)
        FIPminus = try container.decode(Double.self, forKey: .FIPminus)
        xFIPminus = try container.decode(Double.self, forKey: .xFIPminus)
        GBperFB = try container.decode(Double.self, forKey: .GBperFB)
        ldPCT = try container.decode(Double.self, forKey: .ldPCT)
        gbPCT = try container.decode(Double.self, forKey: .gbPCT)
        fbPCT = try container.decode(Double.self, forKey: .fbPCT)
        iffbPCT = try container.decode(Double.self, forKey: .iffbPCT)
        HRperFB = try container.decode(Double.self, forKey: .HRperFB)
        RS = try container.decode(Int.self, forKey: .RS)
        RSper9 = try container.decode(Double.self, forKey: .RSper9)
        balls = try container.decode(Int.self, forKey: .balls)
        strikes = try container.decode(Int.self, forKey: .strikes)
        pitches = try container.decode(Int.self, forKey: .pitches)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        tERA = try container.decode(Double.self, forKey: .tERA)
        WAR = try container.decode(Double.self, forKey: .WAR)
        Kper9plus = try container.decode(Double.self, forKey: .Kper9plus)
        BBper9plus = try container.decode(Double.self, forKey: .BBper9plus)
        KperBBplus = try container.decode(Double.self, forKey: .KperBBplus)
        Hper9plus = try container.decode(Double.self, forKey: .Hper9plus)
        HRper9plus = try container.decode(Double.self, forKey: .HRper9plus)
        AVGplus = try container.decode(Double.self, forKey: .AVGplus)
        WHIPplus = try container.decode(Double.self, forKey: .WHIPplus)
        BABIPplus = try container.decode(Double.self, forKey: .BABIPplus)
        lobPCTplus = try container.decode(Double.self, forKey: .lobPCTplus)
        kPCTplus = try container.decode(Double.self, forKey: .kPCTplus)
        bbPCTplus = try container.decode(Double.self, forKey: .bbPCTplus)
        ldPCTplus = try container.decode(Double.self, forKey: .ldPCTplus)
        gbPCTplus = try container.decode(Double.self, forKey: .gbPCTplus)
        fbPCTplus = try container.decode(Double.self, forKey: .fbPCTplus)
        HRperFBpctPLUS = try container.decode(Double.self, forKey: .HRperFBpctPLUS)
    }
}

struct TeamPitchingResponse: Decodable {
    let data: [TeamPitching]
}
