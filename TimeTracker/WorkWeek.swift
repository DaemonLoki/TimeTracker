//
//  WorkWeek.swift
//  TimeTracker
//
//  Created by Stefan Blos on 26.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import Foundation

struct WorkWeek: Hashable {
    var weekOfYear: Int
    var year: Int
    var workdays: [WorkWeek.Day]
    
    struct Day: Hashable {
        var dayOfWeek: Int
        var workDuration: Double
    }
    
    var workingTime: Double {
        return workdays.reduce(0.0) { (currentValue: Double, day: Day) -> Double in
            currentValue + day.workDuration
        }
    }
    
    var listOfWorkDays: [WorkWeek.Day] {
        var listOfWorkDays = [WorkWeek.Day]()
        for i in 0..<7 {
            let day = workdays.first(where: { $0.dayOfWeek == i })
            listOfWorkDays.append(day ?? WorkWeek.Day(dayOfWeek: i, workDuration: 0.0))
        }
        return listOfWorkDays
    }
}
