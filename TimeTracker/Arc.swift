//
//  Arc.swift
//  TimeTracker
//
//  Created by Stefan Blos on 13.03.20.
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
