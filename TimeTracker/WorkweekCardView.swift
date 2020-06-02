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
            
            VStack {
                HStack {
                    GraphView(points: self.workWeek.listOfWorkDays.map({ (day: WorkWeek.Day) -> Double in
                        day.workDuration
                    }))
                        .frame(height: 250)
                    
                
                }
                
                HStack {
                    ForEach(self.workWeek.listOfWorkDays, id: \.self) { (day: WorkWeek.Day) in
                        Group {
                            Text("\(self.mapIndexToWorkday(day.dayOfWeek))")
                                .foregroundColor(.white)
                                .font(.footnote)
                            
                            if day.dayOfWeek < self.workWeek.listOfWorkDays.count - 1 {
                                Spacer()
                            }
                        }
                    }
                }
                
                
            }
            .padding()
            .background(LinearGradient.cocGradient)
            .clipShape(RoundedRectangle(cornerRadius: .cornerRadius, style: .continuous))
        }
        .padding()
        .background(AdaptiveBackground(shape: RoundedRectangle(cornerRadius: .cornerRadius, style: .continuous)))
        .padding()
    }
    
    func mapIndexToWorkday(_ index: Int) -> String {
        switch index {
        case 0...1:
            return "S"
        case 2:
            return "M"
        case 3:
            return "T"
        case 4:
            return "W"
        case 5:
            return "T"
        case 6:
            return "F"
        default:
            return "Error"
        }
    }
        
}

struct WorkweekCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.myBackground
            
            WorkweekCardView(workWeek: WorkWeek(weekOfYear: 1, year: 2020, workdays: [
                .init(dayOfWeek: 2, workDuration: 8.2),
                .init(dayOfWeek: 3, workDuration: 7.2),
                .init(dayOfWeek: 4, workDuration: 9.2),
                .init(dayOfWeek: 5, workDuration: 6.4),
                .init(dayOfWeek: 6, workDuration: 7.4)]))
        }
        .edgesIgnoringSafeArea(.all)
    }
}
