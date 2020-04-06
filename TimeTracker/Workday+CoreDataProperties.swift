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
}
