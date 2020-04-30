//
//  Workday+CoreDataProperties.swift
//  TimeTracker
//
//  Created by Stefan Blos on 11.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//
//

import Foundation
import CoreData


extension Workday {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workday> {
        return NSFetchRequest<Workday>(entityName: "Workday")
    }

    @NSManaged public var start: Date?
    @NSManaged public var end: Date?
    @NSManaged public var breakDuration: Double
    
    public var unwrappedStart: Date {
        start ?? Date()
    }
    
    public var unwrappedEnd: Date {
        end ?? Date()
    }
    
    var startTimeSet: Bool {
        start != nil
    }
    
    var endTimeSet: Bool {
        end != nil
    }
    
    public var dateString: String {
        start?.dateString() ?? "Unknown"
    }

    public var startTime: String {
        start?.hourString() ?? "--:--"
    }
    
    public var endTime: String {
        end?.hourString() ?? "--:--"
    }
    
    public var workingTime: String {
        guard let start = start, let end = end else { return "0:00 h" }
        return end.difference(to: start, with: Int(self.breakDuration))
    }
    
    public var workDurationInH: Double {
        guard let start = start else { return 0.0 }
        return (Double((self.end ?? Date()).timeIntervalSince(start) / 60) - breakDuration) / 60.0
    }
    
    public var workDur: Double {
        let workingTimeInMinutes = Double(unwrappedEnd.timeIntervalSince(unwrappedStart) / 60) - breakDuration
        let workdayInMinutes = Double(60 * 8) // 8 hours
        let portionOfWorkday = workingTimeInMinutes / workdayInMinutes
        return Double(portionOfWorkday * 360.0)
    }
    
    public var breakDurationString: String {
        let hours = Int(breakDuration / 60)
        let minutes = Int(breakDuration) % 60
        let minutesString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        return "\(hours):\(minutesString)"
    }
}

extension Workday {
    
    static var example: Workday {
        let workday = Workday()
        workday.start = Date()
        workday.end = Date()
        workday.breakDuration = 0.5
        return workday
    }
    
}
