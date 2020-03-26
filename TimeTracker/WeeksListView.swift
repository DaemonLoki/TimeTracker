//
//  WeeksListView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 26.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct WeeksListView: View {
    
    var workWeeks = [WorkWeek]()
    
    init(workdays: FetchedResults<Workday>) {
        let workWeekDict = createDictOfWorkWeeks(workdays: workdays)
        
        
        for weekOfYear in workWeekDict.keys {
            guard let days = workWeekDict[weekOfYear] else { continue }
            guard let year = days.first?.start?.getYear() else { continue }
            workWeeks.append(WorkWeek(weekOfYear: weekOfYear, year: year, workdays: days))
        }
    }
    
    func createDictOfWorkWeeks(workdays: FetchedResults<Workday>) -> [Int: [Workday]] {
        var workWeeks = [Int: [Workday]]()
        for workday in workdays {
            guard let day = workday.start else { continue }
            
            let weekOfYear = day.getWeekOfYear()
            
            if let _ = workWeeks[weekOfYear] {
                workWeeks[weekOfYear]!.append(workday)
            } else {
                workWeeks[weekOfYear] = [workday]
            }
        }
        return workWeeks
    }
    
    var body: some View {
        List {
            ForEach(self.workWeeks, id: \.self) { (workWeek: WorkWeek) in
                VStack {
                    Text("\(workWeek.weekOfYear)")
                }
            .padding()
                
            }
        }
        .background(Color.offWhite)
    }
}
