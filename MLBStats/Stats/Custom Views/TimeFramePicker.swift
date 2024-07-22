//  TimeFramePickerView.swift
//  MLBStats
//  Created by Andrew Xin on 7/22/24.

import SwiftUI

struct TimeFramePicker: View {
    @Binding var selectedTimeFrame: TimeFrame
    
    var body: some View {
        HStack {
            Text("Time Frame:")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            Picker("Select Time Frame", selection: $selectedTimeFrame) {
                ForEach(TimeFrame.allCases, id: \.self) { timeFrame in
                    Text(String(describing: timeFrame)).tag(timeFrame)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 250)
            .padding(.trailing)
        }
    }
}

#Preview {
    TimeFramePicker(selectedTimeFrame: Binding.constant(.SZN))
}
