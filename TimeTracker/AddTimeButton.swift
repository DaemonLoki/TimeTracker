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
    
    var workday: Workday
    
    var body: some View {
        Button(action: {
            self.addTime()
        }) {
            Image(systemName: workday.startTimeSet ? "checkmark" : "plus")
        }
        .buttonStyle(SimpleButtonStyle())
        .animation(.easeInOut)
        .disabled(workday.startTimeSet && workday.endTimeSet)
    }
    
    func addTime() {
        if !(workday.startTimeSet) {
            self.createNewWorkdayWithStartDate()
        } else if !(workday.endTimeSet) {
            self.addEndDateToCurrentWorkday()
        } else {
            print("This should not be possible!")
        }
    }
    
    func createNewWorkdayWithStartDate() {
        let date = Date()
        
        let workDay = Workday(context: self.moc)
        workDay.start = date
        workDay.breakDuration = 0.5
        
        try? self.moc.save()
    }
    
    func addEndDateToCurrentWorkday() {
        if workday.startTimeSet {
            guard let startDate = workday.start else { return }
            self.workday.end = startDate.withHourAndMinute(from: Date())
            
            try? self.moc.save()
        }
    }
}

struct AddTimeButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
            
            AddTimeButton(workday: .example)
        }.edgesIgnoringSafeArea(.all)
    }
}
