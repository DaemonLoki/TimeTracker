//
//  FetchedWorkday.swift
//  TimeTracker
//
//  Created by Stefan Blos on 29.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import CoreData

struct FetchedWorkday<Workday: NSManagedObject, Content: View>: View {
    
    var fetchRequest: FetchRequest<Workday>
    var workdays: FetchedResults<Workday> { fetchRequest.wrappedValue }
    
    let content: (Workday, FetchedResults<Workday>) -> Content
    
    var body: some View {
        if workdays.count > 0 {
            return AnyView(self.content(self.workdays.first!, self.workdays))
        } else {
            return AnyView(WelcomeView())
        }
    }
    
    init(@ViewBuilder content: @escaping (Workday, FetchedResults<Workday>) -> Content) {
        fetchRequest = FetchRequest<Workday>(entity: Workday.entity(), sortDescriptors: [], predicate: FetchedWorkday.createCurrentDayPredicate())
        self.content = content
    }
    
    static func createCurrentDayPredicate() -> NSCompoundPredicate {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        // get today's start and end
        let date = Date()
        let todayFrom = calendar.startOfDay(for: date)
        let todayTo = calendar.date(byAdding: .day, value: 1, to: todayFrom)!
        
        let fromPredicate = NSPredicate(format: "start >= %@", todayFrom as NSDate)
        let toPredicate = NSPredicate(format: "start < %@", todayTo as NSDate)
        return NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
    }
}
