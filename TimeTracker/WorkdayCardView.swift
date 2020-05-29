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
    
    @ObservedObject var workday: Workday
    
    var body: some View {
        ZStack {
            
                HStack(spacing: 20) {
                    WorkdayCardDuration(workingTime: self.workday.workDurationString, workDuration: self.workday.workDur)
                    
                    WorkdayDetails(dayOfWeek: workday.start?.getNameOfWeekday() ?? "Unknown", dateString: self.workday.dateString, startTime: workday.startTime, endTime: workday.endTime, breakDuration: workday.breakDurationString)
                }
                .padding()
                .background(AdaptiveBackground(shape: RoundedRectangle(cornerRadius: 10)))
                .padding(.vertical)
            NavigationLink(destination: SetTimeView(workday: self.workday)) {
                EmptyView()
            }.buttonStyle(PlainButtonStyle())
        }
    }
    
}

struct WorkdayCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkdayCardView(workday: .example)
                .environment(\.colorScheme, .light)
            
            WorkdayCardView(workday: .example)
            .environment(\.colorScheme, .dark)
        }
    }
}

