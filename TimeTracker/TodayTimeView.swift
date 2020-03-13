//
//  TodayTimeView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 12.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct Arc: InsettableShape {
    var startAngle: Angle = .degrees(0)
    var endAngle: Double
    var clockwise: Bool = true
    var insetAmount: CGFloat = 0
    
    var animatableData: Double {
        get { return endAngle }
        set { endAngle = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = .degrees(endAngle) - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct TodayTimeView: View {
    
    var startDate: Date?
    var endDate: Date?
    //var startTimeSet: Bool
    //var endTimeSet: Bool
    
    @State private var endAngle: Double = 0.0
    
    var body: some View {
        ZStack {
            Color.offWhite
            
            VStack {
                Text("Start time:")
                    .font(.footnote)
                
                Text(startDate?.hourString() ?? "--:--")
                    .font(.title)
                
                if endDate != nil {
                    Group {
                        VStack {
                            Text("End time:")
                                .font(.footnote)
                            
                            Text(endDate?.hourString() ?? "00:00")
                                .font(.title)
                        }
                    }
                    .animation(.default)
                }
            
            }
            .padding(60)
            .background(
                Arc(endAngle: endAngle)
                    .stroke(LinearGradient(Color.codecampVeryDarkBlue, Color.codecampLessDarkBlue, Color.codecampABitLightBlue, Color.codecampReallyLightBlue), style: StrokeStyle(lineWidth: 30, lineCap: .round))
                    .animation(.interpolatingSpring(mass: 1, stiffness: 25, damping: 8, initialVelocity: 1))
                    //.animation(.interpolatingSpring(stiffness: 25, damping: 10))
            )
            .padding(40)
            .background(
                Circle()
                    .fill(Color.offWhite)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            )
        }
        .onAppear {
            self.endAngle = self.calculateDuration()
        }
    }
    
    func calculateDuration() -> Double {
        let workingTimeInMinutes = Float((endDate ?? Date()).timeIntervalSince(startDate ?? Date()) / 60)
        let workdayInMinutes = Float(60 * 8) // 8 hours
        let portionOfWorkday = workingTimeInMinutes / workdayInMinutes
        return Double(portionOfWorkday * 360.0)
    }
}

struct TodayTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TodayTimeView(startDate: Date(), endDate: Date())
    }
}
