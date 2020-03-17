//
//  WorkdayCardView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 11.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct WorkdayCardView: View {
    
    @State private var endAngle: Double = 0.0
    
    var workday: Workday
    
    var body: some View {
        HStack(spacing: 20) {
            VStack() {
                Text("TIME")
                    .font(.caption)
                    .foregroundColor(.codecampVeryDarkBlue)
                
                Text(self.workday.workingTime)
                    .font(.headline)
                    .foregroundColor(.codecampVeryDarkBlue)
            }
            .frame(width: 100, height: 100)
            .padding(.vertical, 40)
                .background(
                    Arc(endAngle: endAngle)
                        .stroke(LinearGradient(Color.codecampVeryDarkBlue, Color.codecampLessDarkBlue, Color.codecampABitLightBlue, Color.codecampReallyLightBlue), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .animation(.interpolatingSpring(mass: 1, stiffness: 25, damping: 8, initialVelocity: 1))
                )
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
        .onAppear {
            self.endAngle = self.calculateDuration()
        }
    }
    
    func calculateDuration() -> Double {
        guard let start = workday.start else { return 0.0 }
        let workingTimeInMinutes = Double((workday.end ?? Date()).timeIntervalSince(start) / 60) - workday.breakDuration
        let workdayInMinutes = Double(60 * 8) // 8 hours
        let portionOfWorkday = workingTimeInMinutes / workdayInMinutes
        return Double(portionOfWorkday * 360.0)
    }
}
