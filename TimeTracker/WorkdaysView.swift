//
//  WorkdaysView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 11.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import CoreData

struct WorkdaysView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Workday.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Workday.start, ascending: false)]) var workdays: FetchedResults<Workday>
    
    @Binding var startTimeSet: Bool
    @Binding var endTimeSet: Bool
    @Binding var workday: Workday?
        
    var body: some View {
        List {
            ForEach(self.workdays, id: \.self) { (workday: Workday) in
                WorkdayCardView(workday: workday)
                    .listRowBackground(Color.offWhite)
            }
            .onDelete(perform: removeDay)
            .background(Color.offWhite)
            
        }
        .background(Color.offWhite)
        .navigationBarTitle("Your workdays")
    }
    
    func removeDay(at offsets: IndexSet) {
        guard let firstIndex = offsets.first else { return }
        
        let currentWorkday = self.workday
    
        let workday = workdays[firstIndex]
        self.moc.delete(workday)
        
        try? self.moc.save()
        
        guard let currentWorkdayUnwrapped = currentWorkday else { return }
        if workday == currentWorkdayUnwrapped {
            startTimeSet = false
            endTimeSet = false
        }
    }
}
