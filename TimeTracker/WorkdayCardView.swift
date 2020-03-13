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
        HStack {
            VStack(alignment: .leading) {
                Text(self.workday.dateString)
                    .font(.largeTitle)
                
                Text("From: \(self.workday.startTime)")
                    .font(.headline)
                
                Text("To: \(self.workday.endTime)")
                    .font(.headline)
            }
            .padding()
            
            Spacer()
            
            Text(self.workday.workingTime)
                .font(.largeTitle)
        }
            .padding()
        .background(FancyBackground(shape: RoundedRectangle(cornerRadius: 10)))
    .padding()
    
        
    }
}
