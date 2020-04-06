//
//  WorkdayCardDuration.swift
//  TimeTracker
//
//  Created by Stefan Blos on 06.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct WorkdayCardDuration: View {
    
    var workingTime: String
    var workDuration: Double
    
    @State private var endAngle: Double = 0.0
    
    var body: some View {
        
        Text(workingTime)
            .font(.subheadline)
            .foregroundColor(.codecampVeryDarkBlue)
            .frame(width: 60)
            .padding(.vertical, 20)
            .background(
                Arc(endAngle: endAngle)
                    .stroke(LinearGradient(Color.codecampVeryDarkBlue, Color.codecampLessDarkBlue, Color.codecampABitLightBlue, Color.codecampReallyLightBlue), style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .animation(.interpolatingSpring(mass: 1, stiffness: 25, damping: 8, initialVelocity: 1))
            )
            .padding(15)
            .background(FancyBackground(shape: Circle(), isHighlighted: true))
            .onAppear {
                self.endAngle = self.workDuration
        }
        
    }
}

struct WorkdayCardDuration_Previews: PreviewProvider {
    static var previews: some View {
        WorkdayCardDuration(workingTime: "99:99", workDuration: 190.0)
    }
}
