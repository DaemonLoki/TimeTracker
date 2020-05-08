//
//  FetchedWorkday.swift
//  TimeTracker
//
//  Created by Stefan Blos on 29.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import CoreData

struct FetchedWorkday<Content: View>: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var fetchRequest: FetchRequest<Workday>
    var workdays: FetchedResults<Workday> { fetchRequest.wrappedValue }
    var currentDate: Date
    
    @FetchRequest(entity: Workday.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Workday.start, ascending: false)]) var allWorkdays: FetchedResults<Workday>
    
    let content: (Workday, FetchedResults<Workday>) -> Content
    
    var body: some View {
        if allWorkdays.count > 0 {
            guard workdays.first != nil else {
                let workday = Workday(context: self.moc)
                workday.start = Date()
                
                return AnyView(Text("Loading").onAppear {
                    try? self.moc.save()
                })
            }
            return AnyView(self.content(self.workdays.first!, self.workdays))
        } else {
            return AnyView(WelcomeView())
        }
    }
    
    init(currentDate: Date, @ViewBuilder content: @escaping (Workday, FetchedResults<Workday>) -> Content) {
        self.currentDate = currentDate
        self.fetchRequest = FetchRequest<Workday>(entity: Workday.entity(), sortDescriptors: [], predicate: FetchedWorkday.createCurrentDayPredicate(for: Date()))
        self.content = content
    }
    
    static func createCurrentDayPredicate(for date: Date) -> NSCompoundPredicate {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        // get today's start and end
        let todayFrom = calendar.startOfDay(for: date)
        let todayTo = calendar.date(byAdding: .day, value: 1, to: todayFrom)!
        
        let fromPredicate = NSPredicate(format: "start >= %@", todayFrom as NSDate)
        let toPredicate = NSPredicate(format: "start < %@", todayTo as NSDate)
        return NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
    }
}
