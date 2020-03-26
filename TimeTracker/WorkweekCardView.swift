//
//  WorkweekCardView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 26.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct WorkweekCardView: View {
    
    var workWeek: WorkWeek
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Week \(workWeek.weekOfYear)")
                .font(.largeTitle)
            
            Text("Year \(workWeek.year)")
            
            Text("Working time: \(workWeek.workingTime)")
        }
        .padding()
        .background(FancyBackground(shape: RoundedRectangle(cornerRadius: 10)))
    }
}

struct WorkweekCardView_Previews: PreviewProvider {
    static var previews: some View {
        WorkweekCardView(workWeek: WorkWeek(weekOfYear: 1, year: 2020, workdays: []))
    }
}
