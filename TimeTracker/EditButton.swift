//
//  EditButton.swift
//  TimeTracker
//
//  Created by Stefan Blos on 06.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct EditButton: View {
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var workDay: Workday?
    @Binding var breakDuration: Double
    
    @State private var currentOffset: CGFloat = 0
    @State private var currentScale: CGFloat = 0
    
    var body: some View {
        NavigationLink(destination: SetTimeView(startDate: $startDate, endDate: $endDate, workday: $workDay, breakDuration: $breakDuration)) {
            Image(systemName: "pencil")
                .foregroundColor(.white)
        }
        .padding(20)
        .contentShape(Circle())
        .background(FancyBackground(shape: Circle(), backgroundColor: .codecampVeryDarkBlue))
        .offset(x: currentOffset, y: currentOffset)
        .scaleEffect(currentScale)
        .animation(.easeInOut)
        .onAppear {
            self.currentOffset = 98
            self.currentScale = 1
        }
    }
}

struct EditButton_Previews: PreviewProvider {
    static var previews: some View {
        EditButton(startDate: Binding.constant(Date()), endDate: Binding.constant(Date()), workDay: Binding.constant(nil), breakDuration: Binding.constant(0.0))
    }
}