//  Pitcher.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

struct Pitcher: Identifiable, Decodable {
    let pitchHand: String
    let id: Int
    let ageR: String
    let age: Int
    let W: Int
    let L: Int
    let ERA: Double
    let G: Int
    let GS: Int
    let QS: Int
    let SV: Int
    let HLD: Int
    let BS: Int
    let IP: Double
    let TBF: Int
    let H: Int
    let R: Int
    let ER: Int
    let HR: Int
    let BB: Int
    let IBB: Int
    let HBP: Int
    let WP: Int
    let BK: Int
    let SO: Int
    let Kper9: Double
    let BBper9: Double
    let Hper9: Double
    let KperBB: Double
    let ifhPCT: Double
    let buhPCT: Double
    let ttoPCT: Double
    let GB: Int
    let FB: Int
    let LD: Int
    let IFFB: Int
    let IFH: Int
    let BU: Int
    let BUH: Int
    let kPCT: Double
    let bbPCT: Double
    let kMINUSbbPCT: Double
    let SIERA: Double
    let HRper9: Double
    let AVG: Double
    let WHIP: Double
    let BABIP: Double
    let lobPCT: Double
    let FIP: Double
    let kwERA: Double
    let xFIP: Double
    let GBperFB: Double
    let ldPCT: Double
    let gbPCT: Double
    let fbPCT: Double
    let iffbPCT: Double
    let HRperFB: Double
    let RS: Int
    let RSper9: Double
    let balls: Int
    let strikes: Int
    let pitches: Int
    let name: String
    let teamName: String
    let teamId: Int
    let tERA: Double
    let WAR: Double
    // *Plus Stats*
    let Kper9plus: Double
    let BBper9plus: Double
    let KperBBplus: Double
    let Hper9plus: Double
    let HRper9plus: Double
    let AVGplus: Double
    let WHIPplus: Double
    let BABIPplus: Double
    let lobPCTplus: Double
    let kPCTplus: Double
    let bbPCTplus: Double
    let ldPCTplus: Double
    let gbPCTplus: Double
    let fbPCTplus: Double
    let HRperFBplus: Double
    
    enum CodingKeys: String, CodingKey {
        case pitchHand = "Throws"
        case id = "xMLBAMID"
        case ageR = "AgeR"
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
        case name = "PlayerName"
        case teamName = "TeamName"
        case teamId = "teamid"
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
        case HRperFBplus = "HRFB%+"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pitchHand = try container.decode(String.self, forKey: .pitchHand)
        id = try container.decode(Int.self, forKey: .id)
        ageR = try container.decode(String.self, forKey: .ageR)
        age = ageR.extractMaxAge()
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
        teamName = try container.decode(String.self, forKey: .teamName)
        teamId = try container.decode(Int.self, forKey: .teamId)
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
        HRperFBplus = try container.decode(Double.self, forKey: .HRperFBplus)
    }
}

struct PitchersResponse: Decodable {
    let data: [Pitcher]
}
