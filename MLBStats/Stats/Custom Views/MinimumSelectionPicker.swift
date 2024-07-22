//  MinimumSelectionPicker.swift
//  MLBStats
//  Created by Andrew Xin on 7/22/24.

import SwiftUI

struct MinimumSelectionPicker<T: Hashable>: View {
    let title: String
    let items: [T]
    @Binding var selection: T
    
    var body: some View {
        HStack {
            Text("\(title):")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            Picker("Select \(title)", selection: $selection) {
                ForEach(items, id: \.self) { item in
                    Text("\(item)").tag(item)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 250)
            .padding(.trailing)
        }
    }
}

#Preview {
    MinimumSelectionPicker(title: "Minimum PAs", items: [25, 50, 75, 100, 200], selection: Binding.constant(25))
}
