//  FielderStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/20/24.

import SwiftUI

struct FielderStatsView: View {
    var body: some View {
        List(viewModel.fielders) { fielder in
            VStack(alignment: .leading) {
                Text(fielder.name)
                    .font(.headline)
            }
        }
        .navigationTitle("MLB Fielders")
    }
}

#Preview {
    FielderStatsView()
}
