//  NumberOfResultsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/22/24.

import SwiftUI

struct NumberOfResultsView: View {
    let title: String
    let count: Int
    
    var body: some View {
        Text("Number of Results: \(count)")
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 5)
            .padding(.leading)
    }
}

#Preview {
    NumberOfResultsView(title: "Hitters", count: 400)
}
