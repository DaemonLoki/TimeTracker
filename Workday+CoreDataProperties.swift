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
        start?.hourString() ?? "Unknown"
    }
    
    public var endTime: String {
        end?.hourString() ?? "Unknown"
    }
    
    public var workingTime: String {
        guard let start = start, let end = end else { return "0:00 h" }
        let timeInterval = end.timeIntervalSince(start)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]

        //formatter.dateFormat = "HH:mm"
        guard let hourString = formatter.string(from: timeInterval) else { return "0:00 h"}
        return "\(hourString)"
    }
}
