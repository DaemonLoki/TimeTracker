//
//  WorkdayCardView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 11.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct WorkdayCardView: View {
    var workday: Workday
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: -10) {
                Text("HOURS\n")
                    .font(.caption)
                    .foregroundColor(.codecampVeryDarkBlue)
                
                Text(self.workday.workingTime)
                    .font(.headline)
                    .foregroundColor(.codecampVeryDarkBlue)
            }
                .padding(30)
                .background(FancyBackground(shape: Circle(), isHighlighted: true))
            
            
            VStack(alignment: .leading) {
                Text(self.workday.dateString)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                Text("From: \(self.workday.startTime)")
                    .font(.subheadline)
                
                Text("To: \(self.workday.endTime)")
                    .font(.subheadline)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .background(FancyBackground(shape: RoundedRectangle(cornerRadius: 10)))
        .padding()
        
        
    }
}
