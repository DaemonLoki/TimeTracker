//
//  AddTimeButton.swift
//  TimeTracker
//
//  Created by Stefan Blos on 06.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct AddTimeButton: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @Binding var startTimeSet: Bool
    @Binding var endTimeSet: Bool
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var workDay: Workday?
    
    var fetchedDays: FetchedResults<Workday>?
    
    var body: some View {
        Button(action: {
            self.addTime()
        }) {
            Image(systemName: startTimeSet ? "checkmark" : "plus")
        }
        .buttonStyle(SimpleButtonStyle())
        .animation(.easeInOut)
        .disabled(startTimeSet && endTimeSet)
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
        guard let fetchedDays = fetchedDays else { return }
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

struct AddTimeButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
            
            AddTimeButton(startTimeSet: Binding.constant(false), endTimeSet: Binding.constant(false), startDate: Binding.constant(Date()), endDate: Binding.constant(Date()), workDay: Binding.constant(nil))
        }.edgesIgnoringSafeArea(.all)
    }
}
