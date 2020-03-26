//
//  ContentView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 11.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var fetchRequest: FetchRequest<Workday>
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    @State private var startTimeSet = false
    @State private var endTimeSet = false
    
    @State private var breakDuration = 0.0
    
    @State private var workDay: Workday? = nil
    
    let buttonSize: CGFloat = 80
    
    init() {
        // get current calendar
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        // get today's start and end
        let date = Date()
        let todayFrom = calendar.startOfDay(for: date)
        let todayTo = calendar.date(byAdding: .day, value: 1, to: todayFrom)!
        
        let fromPredicate = NSPredicate(format: "start >= %@", todayFrom as NSDate)
        let toPredicate = NSPredicate(format: "start < %@", todayTo as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        fetchRequest = FetchRequest<Workday>(entity: Workday.entity(), sortDescriptors: [], predicate: datePredicate)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.offWhite
                
                VStack {
                    ZStack {
                        TodayTimeView(startDate: self.startDate, startTimeSet: self.startTimeSet, endDate: self.endDate, endTimeSet: self.endTimeSet, breakDuration: self.breakDuration)
                    
                        if startTimeSet {
                            NavigationLink(destination: SetTimeView(startDate: $startDate, endDate: $endDate, workday: $workDay, breakDuration: $breakDuration)) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.white)
                            }
                            .padding(20)
                            .contentShape(Circle())
                            .background(FancyBackground(shape: Circle(), backgroundColor: .codecampVeryDarkBlue))
                            .offset(x: 98, y: 98)
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        NavigationLink(destination: WorkdaysView(startTimeSet: $startTimeSet, endTimeSet: $endTimeSet, currentWorkday: $workDay)) {
                            Image(systemName: "list.bullet")
                        }
                        .buttonStyle(SimpleButtonStyle())
                        
                        Spacer()
                        
                        Button(action: {
                            self.addTime()
                        }) {
                            if startTimeSet {
                                Image(systemName: "checkmark")
                            } else {
                                Image(systemName: "plus")
                            }
                        }
                        .buttonStyle(SimpleButtonStyle())
                        .disabled(startTimeSet && endTimeSet)
                        
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Time Tracker")
        }
        .onAppear {
            let fetchedDays = self.fetchRequest.wrappedValue
            // we already have data for the current day
            if fetchedDays.count > 0 {
                // we already have a start for the day
                self.workDay = fetchedDays[0]
                guard let startDate = fetchedDays[0].start else { return }
                self.startDate = startDate
                self.startTimeSet = true
                
                self.breakDuration = fetchedDays[0].breakDuration
                
                // we already have an end for the day
                guard let endDate = fetchedDays[0].end else { return }
                self.endDate = endDate
                self.endTimeSet = true
            }
        }
        
    }
    
    func addTime() {
        if !startTimeSet {
            self.createNewWorkdayWithStartDate()
        } else if !endTimeSet {
            self.addEndDateToCurrentWorkday()
        } else {
            print("This should not be possible!")
        }
    }
    
    func createNewWorkdayWithStartDate() {
        let date = Date()
        self.startDate = date
        self.startTimeSet = true
        
        let workDay = Workday(context: self.moc)
        workDay.start = date
        
        self.workDay = workDay
        
        try? self.moc.save()
    }
    
    func addEndDateToCurrentWorkday() {
        let fetchedDays = self.fetchRequest.wrappedValue
        if startTimeSet {
            guard let _ = fetchedDays[0].start else { return }
            let date = Date()
            self.endDate = date
            self.endTimeSet = true
            
            fetchedDays[0].end = date
            
            fetchedDays[0].breakDuration = 0.5
            
            self.workDay = fetchedDays[0]
            workDay?.end = date
            
            try? self.moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
