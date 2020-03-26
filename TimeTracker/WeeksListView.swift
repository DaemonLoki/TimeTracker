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
        
        
        for weekOfYear in workWeekDict.keys.sorted().reversed() {
            guard let days = workWeekDict[weekOfYear]?.1, let year = workWeekDict[weekOfYear]?.0 else { continue }
            guard days.count > 0 else { continue }
            workWeeks.append(WorkWeek(weekOfYear: weekOfYear, year: year, workdays: days))
        }
    }
    
    func createDictOfWorkWeeks(workdays: FetchedResults<Workday>) -> [Int: (Int, [WorkWeek.Day])] {
        var workWeeks = [Int: (Int, [WorkWeek.Day])]()
        for workday in workdays {
            guard let day = workday.start else { continue }
            
            let year = day.getYear()
            let weekOfYear = day.getWeekOfYear()
            let dayOfWeek = day.getDayOfWeek()
            
            let workWeekDay = WorkWeek.Day(dayOfWeek: dayOfWeek, workDuration: workday.workDurationInH)
            
            if let _ = workWeeks[weekOfYear] {
                workWeeks[weekOfYear]!.1.append(workWeekDay)
            } else {
                workWeeks[weekOfYear] = (year, [workWeekDay])
            }
        }
        return workWeeks
    }
    
    var body: some View {
        List {
            ForEach(self.workWeeks, id: \.self) { (workWeek: WorkWeek) in
                WorkweekCardView(workWeek: workWeek)
                    .listRowBackground(Color.offWhite)
            }
        }
        .background(Color.offWhite)
    }
}
