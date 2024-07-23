//  TeamIdMapping.swift
//  MLBStats
//  Created by Andrew Xin on 7/22/24.

import Foundation

// Dictionary mapping statsAPI's teamIds to fangraphAPI's
let teamIdMapping: [Int: Int] = [
    108: 1,     // LAA
    109: 15,    // ARI
    110: 2,     // BAL
    111: 3,     // BOS
    112: 17,    // CHC
    113: 18,    // CIN
    114: 5,     // CLE
    115: 19,    // COL
    116: 6,     // DET
    117: 21,    // HOU
    118: 7,     // KC - KCR
    119: 22,    // LAD
    120: 24,    // WSH - WSN
    121: 25,    // NYM
    133: 10,    // OAK
    134: 27,    // PIT
    135: 29,    // SD - SDP
    136: 11,    // SEA
    137: 30,    // SF - SFG
    138: 28,    // STL
    139: 12,    // TB - TBR
    140: 13,    // TEX
    141: 14,    // TOR
    142: 8,     // MIN
    143: 26,    // PHI
    144: 16,    // ATL
    145: 4,     // CWS - CHW
    146: 20,    // MIA
    147: 9,     // NYY
    158: 23     // MIL
]

var reverseTeamIdMapping: [Int: Int] = {
    Dictionary(uniqueKeysWithValues: teamIdMapping.map { ($1, $0) })
}()

func mapTeamId(fromStatsAPI id: Int) -> Int? {
    return teamIdMapping[id]
}

func mapTeamId(fromFanGraphsAPI id: Int) -> Int? {
    return reverseTeamIdMapping[id]
}
