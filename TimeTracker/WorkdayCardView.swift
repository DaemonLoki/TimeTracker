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
    var workDuration: Double
    
    init(workday: Workday) {
        self.workday = workday
        
        guard let start = workday.start else {
            self.workDuration = 0.0
            return
        }
        let workingTimeInMinutes = Double((workday.end ?? Date()).timeIntervalSince(start) / 60) - workday.breakDuration
        let workdayInMinutes = Double(60 * 8) // 8 hours
        let portionOfWorkday = workingTimeInMinutes / workdayInMinutes
        self.workDuration = Double(portionOfWorkday * 360.0)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            WorkdayCardDuration(workingTime: String(format: "%.2f h", self.workday.workDurationInH), workDuration: self.workDuration)
            
            WorkdayDetails(dayOfWeek: workday.start!.getNameOfWeekday(), dateString: self.workday.dateString, startTime: workday.startTime, endTime: workday.endTime)
        }
        .padding()
        .background(FancyBackground(shape: RoundedRectangle(cornerRadius: 10)))
        .padding()
    }
    
}
