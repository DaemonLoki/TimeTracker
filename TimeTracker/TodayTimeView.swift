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
    
    var startTime: String?
    var endTime: String?
    //var startTimeSet: Bool
    //var endTimeSet: Bool
    
    var body: some View {
        ZStack {
            Color.offWhite
            
            VStack {
                Text("Start time:")
                    .font(.footnote)
                
                Text(startTime ?? "00:00")
                    .font(.title)
                
                if endTime != nil {
                    Group {
                        VStack {
                            Text("End time:")
                                .font(.footnote)
                            
                            Text(endTime ?? "00:00")
                                .font(.title)
                        }
                    }
                    .animation(.default)
                }
            
            }
            .padding(60)
            .background(
                Arc(endAngle: endTime != nil ? 190 : 0)
                    .stroke(LinearGradient(Color.blue, Color.red), style: StrokeStyle(lineWidth: 30, lineCap: .round))
                    .animation(.interactiveSpring())
            )
            .padding(40)
            .background(
                Circle()
                    .fill(Color.offWhite)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            )
        }
        
    }
}

struct TodayTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TodayTimeView(startTime: "07:28", endTime: "16:54")
    }
}
