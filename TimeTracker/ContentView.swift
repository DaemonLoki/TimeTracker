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
    //@FetchRequest(entity: Workday.entity(), sortDescriptors: []) var days: FetchedResults<Workday>
    
    var fetchRequest: FetchRequest<Workday>
    
    @State private var startTime = ""
    @State private var endTime = ""
    
    @State private var startTimeSet = false
    @State private var endTimeSet = false
    
    let buttonSize: CGFloat = 80
    
    init() {
        // get current calendar
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        let date = Date()
        
        // get today's start and end
        let todayFrom = calendar.startOfDay(for: date)
        let todayTo = calendar.date(byAdding: .day, value: 1, to: todayFrom)!
        
        let fromPredicate = NSPredicate(format: "%@ >= %@", date as NSDate, todayFrom as NSDate)
        let toPredicate = NSPredicate(format: "%@ < %@", date as NSDate, todayTo as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        fetchRequest = FetchRequest<Workday>(entity: Workday.entity(), sortDescriptors: [], predicate: datePredicate)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Start time:")
                    .font(.subheadline)
                
                Text(startTime == "" ? "--:--" : startTime)
                    .font(.largeTitle)
                
                Text("End time:")
                    .font(.subheadline)
                
                Text(endTime == "" ? "--:--" : endTime)
                    .font(.largeTitle)
                
                Spacer()
                
                HStack(spacing: 20) {
                    Button("Leave") {
                        self.addEnd()
                    }
                    .foregroundColor(.primary)
                    .padding()
                    .frame(width: 100, height: 50)
                    .background(Circle().foregroundColor(.red).frame(width: buttonSize, height: buttonSize))
                    .padding()
                    .opacity(endTimeSet ? 0.3 : 1.0)
                    .disabled(endTimeSet)
                    
                    NavigationLink(destination: WorkdaysView()) {
                        Text("List")
                            .foregroundColor(.primary)
                            .padding()
                            .frame(width: 100, height: 50)
                            .background(Circle().foregroundColor(.blue).frame(width: buttonSize, height: buttonSize))
                            .padding()
                    }
                    
                    Button("Start") {
                        self.addStart()
                    }
                    .foregroundColor(.primary)
                    .padding()
                    .frame(width: 100, height: 50)
                    .background(Circle().foregroundColor(.green).frame(width: buttonSize, height: buttonSize))
                    .padding()
                    .opacity(startTimeSet ? 0.3 : 1.0)
                    .disabled(startTimeSet)
                }
                .padding()
            }
            .navigationBarTitle("Time Tracker")
        }
        .onAppear {
            let fetchedDays = self.fetchRequest.wrappedValue
            // we already have data for the current day
            if fetchedDays.count == 1 {
                // we already have a start for the day
                guard let startDate = fetchedDays[0].start else { return }
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                self.startTime = formatter.string(from: startDate)
                self.startTimeSet = true
                
                // we already have an end for the day
                guard let endDate = fetchedDays[0].end else { return }
                self.endTime = formatter.string(from: endDate)
                self.endTimeSet = true
            }
        }
    }
    
    func addStart() {
        print("start")
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        self.startTime = formatter.string(from: date)
        self.startTimeSet = true
        
        let workDay = Workday(context: self.moc)
        workDay.start = date
        
        try? self.moc.save()
    }
    
    func addEnd() {
        let fetchedDays = self.fetchRequest.wrappedValue
        if fetchedDays.count == 1 {
            guard let _ = fetchedDays[0].start else { return }
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            self.endTime = formatter.string(from: date)
            self.endTimeSet = true
            
            fetchedDays[0].end = date
            
            fetchedDays[0].breakDuration = 0.5
            
            try? self.moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
