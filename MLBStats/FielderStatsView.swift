//  FielderStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct FielderStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        List(viewModel.fielders) { fielder in
            VStack(alignment: .leading) {
                Text(fielder.name)
                    .font(.headline)
            }
        }
        .navigationTitle("MLB Fielders")
        .task {
            await viewModel.fetchFielders()
        }
    }
}

#Preview {
    FielderStatsView()
}
