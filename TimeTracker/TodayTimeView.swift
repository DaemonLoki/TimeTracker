//
//  TodayTimeView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 12.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import Combine

struct TodayTimeView: View {
    
    @State private var endAngle: Double = 0.0
    
    @ObservedObject var workday: Workday
    
    var body: some View {
        ZStack {
            Color.myBackground
            
            VStack {
                Text("Start time:")
                    .font(.footnote)
                
                Text(self.workday.startTimeSet ? self.workday.start!.hourString() : "--:--")
                    .font(.title)
                
                if self.workday.endTimeSet {
                    Group {
                        VStack {
                            Text("End time:")
                                .font(.footnote)
                            
                            Text(self.workday.end!.hourString())
                                .font(.title)
                        }
                    }
                    .animation(.default)
                }
            
            }
            .padding(60)
            .background(
                Arc(endAngle: endAngle)
                    .stroke(LinearGradient.cocGradient, style: StrokeStyle(lineWidth: 30, lineCap: .round))
                    .animation(.interpolatingSpring(mass: 1, stiffness: 25, damping: 8, initialVelocity: 1))
            )
            .padding(40)
            .background(
                AdaptiveBackground(shape: Circle())
            )
        }
        .onAppear {
            self.endAngle = self.calculateDuration()
        }
    }
    
    func calculateDuration() -> Double {
        if workday.startTimeSet {
            let currentEnd = workday.unwrappedEnd
            let workingTimeInMinutes = Double(currentEnd.timeIntervalSince(workday.unwrappedStart) / 60) - workday.breakDuration
            let workdayInMinutes = Double(60 * 8) // 8 hours
            let portionOfWorkday = workingTimeInMinutes / workdayInMinutes
            let portionOfWorkdayDegree = Double(portionOfWorkday * 360.0)
            return portionOfWorkdayDegree
        } else {
            return 0.0
        }
    }
}


struct TodayTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TodayTimeView(workday: Workday.example)
    }
}
