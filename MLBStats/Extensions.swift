//  Extensions.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import Foundation

extension String {
    // Extracts the higher bound from an age range string like "30 - 32".
    func extractMaxAge() -> Int {
        let components = self.split(separator: " - ")
        if components.count == 2, let highBound = Int(components[1]) {
            return highBound
        }
        return 0
    }
}
