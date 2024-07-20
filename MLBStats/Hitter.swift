//  Hitter.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

struct Hitter: Identifiable, Decodable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "playerid"
        case name = "Name"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        
        let nameWithHTML = try container.decode(String.self, forKey: .name)
        name = Hitter.stripHTML(from: nameWithHTML)
    }
    
    private static func stripHTML(from html: String) -> String {
        let htmlData = Data(html.utf8)
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        if let attributedString = try? NSAttributedString(data: htmlData, options: options, documentAttributes: nil) {
            return attributedString.string
        }
        return html
    }
}

struct HittersResponse: Decodable {
    let data: [Hitter]
}
