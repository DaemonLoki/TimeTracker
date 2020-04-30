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
        NavigationLink(destination: SetTimeView(workday: self.workday)) {
            HStack(spacing: 20) {
                WorkdayCardDuration(workingTime: String(format: "%.2f h", self.workday.workDurationInH), workDuration: self.workday.workDur)
                
                WorkdayDetails(dayOfWeek: workday.start!.getNameOfWeekday(), dateString: self.workday.dateString, startTime: workday.startTime, endTime: workday.endTime)
            }
            .padding()
            .background(FancyBackground(shape: RoundedRectangle(cornerRadius: 10)))
            .padding(.vertical)
        }
    }
    
}



struct WorkdayCardView_Previews: PreviewProvider {
    static var previews: some View {
        WorkdayCardView(workday: .example)
    }
}

