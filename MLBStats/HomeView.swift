//  HomeView.swift
//  MLBStats
//  Created by Andrew Xin on 8/1/24.

import SwiftUI

struct HomeView: View {
    @State var index = 0
    
    var body: some View {
        VStack {
            ZStack {
                if self.index == 0 {
                    StatsView()
                } else if self.index == 1  {
                    ScheduleView()
                } else if self.index == 2  {
                    
                } else {
                    
                }
            }
            .padding(.bottom, -35)
            CustomTabView(index: self.$index)
        }
    }
}

struct CustomTabView: View {
    @Binding var index: Int
    
    var body: some View {
        HStack {
            Button(action: {
                self.index = 0
            }) {
                Image(systemName: "house.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .foregroundColor(Color.black.opacity(self.index == 0 ? 1 : 0.2))
            .offset(x: 10, y: 10)
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                self.index = 1
            }) {
                Image(systemName: "calendar.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .foregroundColor(Color.black.opacity(self.index == 1 ? 1 : 0.2))
            .offset(x: 5, y: 10)
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                self.index = 2
            }) {
                Image(systemName: "bookmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .foregroundColor(Color.black.opacity(self.index == 2 ? 1 : 0.2))
            .offset(x: -5, y: 10)
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                self.index = 3
            }) {
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .foregroundColor(Color.black.opacity(self.index == 3 ? 1 : 0.2))
            .offset(x: -10, y: 10)
        }
        .padding(.horizontal, 35)
        .background(.white)
    }
}

#Preview {
    HomeView()
}
