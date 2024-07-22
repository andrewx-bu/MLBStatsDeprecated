//  SeasonRangePicker.swift
//  MLBStats
//  Created by Andrew Xin on 7/22/24.

import SwiftUI

struct SeasonRangePicker: View {
    @Binding var selectedSeasonRange: SeasonRange
    
    var body: some View {
        HStack {
            Text("Time Frame:")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            Picker("Select Season Range", selection: $selectedSeasonRange) {
                ForEach(SeasonRange.allCases, id: \.rawValue) { range in
                    Text(range.rawValue).tag(range)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 250)
            .padding(.trailing)
        }
    }
}

#Preview {
    SeasonRangePicker(selectedSeasonRange: Binding.constant(.SZN))
}
