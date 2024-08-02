//  StatsView.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import SwiftUI

struct StatsView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select View", selection: $viewModel.currentView) {
                    ForEach(ViewModel.CurrentView.allCases, id: \.self) { view in
                        Text(view.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                switch viewModel.currentView {
                case .Hitters:
                    HitterStatsView()
                case .Pitchers:
                    PitcherStatsView()
                case .Fielders:
                    FielderStatsView()
                case .Catchers:
                    CatcherStatsView()
                }
            }
        }
    }
}

#Preview {
    StatsView()
}
