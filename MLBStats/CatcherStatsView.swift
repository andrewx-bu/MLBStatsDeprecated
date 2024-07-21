//  CatcherStatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/21/24.

import SwiftUI

struct CatcherStatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(1.5, anchor: .center)
                .padding()
        } else {
            List(viewModel.catchers) { catcher in
                VStack(alignment: .leading) {
                    Text(catcher.name)
                        .font(.headline)
                }
            }
            .navigationTitle("MLB Catchers")
            .task {
                await viewModel.fetchCatchers()
            }
        }
    }
}

#Preview {
    CatcherStatsView()
}
