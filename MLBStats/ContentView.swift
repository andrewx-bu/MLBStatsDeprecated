//  ContentView.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import SwiftUI

struct ContentView: View {
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
                
                switch viewModel.currentView {
                case .hitters:
                    HitterStatsView()
                case .pitchers:
                    PitcherStatsView()
                case .fielders:
                    FielderStatsView()
                case .catchers:
                    CatcherStatsView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
