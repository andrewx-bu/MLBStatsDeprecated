//  ContentView.swift
//  MLBStats
//  Created by Andrew Xin on 7/14/24.

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select View", selection: $viewModel.currentView) {
                    ForEach(ViewModel.CurrentView.allCases, id: \.self) { view in
                        Text(view.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.5, anchor: .center)
                        .padding()
                } else {
                    switch viewModel.currentView {
                    case .hitters:
                        List(viewModel.hitters) { hitter in
                            VStack(alignment: .leading) {
                                Text("\(hitter.name) (\(hitter.age ?? 0))")
                                    .font(.headline)
                                Text("Bats: \(hitter.batSide)")
                                    .font(.caption)
                                Text("ID: " + String(hitter.id))
                                    .font(.caption)
                            }
                        }
                        .navigationTitle("MLB Hitters")
                        
                    case .pitchers:
                        List(viewModel.pitchers, id: \.self) { pitcher in
                            VStack(alignment: .leading) {
                                Text(pitcher.Name)
                                    .font(.headline)
                            }
                        }
                        .navigationTitle("MLB Pitchers")
                        
                    case .fielders:
                        List(viewModel.fielders) { fielder in
                            VStack(alignment: .leading) {
                                Text(fielder.name)
                                    .font(.headline)
                            }
                        }
                        .navigationTitle("MLB Fielders")
                    }
                }
            }
            .task {
                await viewModel.loadCurrentViewData()
            }
            .onChange(of: viewModel.currentView) {
                Task {
                    await viewModel.loadCurrentViewData()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
