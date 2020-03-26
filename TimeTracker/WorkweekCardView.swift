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
        VStack(spacing: 10) {
            HStack {
                Text("Week \(self.workWeek.weekOfYear)")
                    .font(.largeTitle)
                
                Spacer()
            }
            
            HStack {
                Text("Working time: \(self.workWeek.workingTime, specifier: "%.2f") h")
                
                Spacer()
            }
            .padding(.vertical)
            
            HStack {
                ForEach(self.workWeek.listOfWorkDays, id: \.self) { (day: WorkWeek.Day) in
                    VStack {
                        Spacer()
                        
                        Capsule()
                            .fill(LinearGradient(Color.codecampVeryDarkBlue, Color.codecampLessDarkBlue, Color.codecampABitLightBlue, Color.codecampReallyLightBlue))
                            .frame(width: 25, height: CGFloat(day.workDuration * 10))
                        
                        
                        Text("\(day.dayOfWeek)")
                            .font(.footnote)
                    }
                }
            }
            .padding()
            .background(FancyBackground(shape: RoundedRectangle(cornerRadius: 10), isHighlighted: true))
        }
        .padding()
        .background(FancyBackground(shape: RoundedRectangle(cornerRadius: 10)))
        .padding()
    }
    
}

struct WorkweekCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
            
            WorkweekCardView(workWeek: WorkWeek(weekOfYear: 1, year: 2020, workdays: []))
        }
        .edgesIgnoringSafeArea(.all)
    }
}
