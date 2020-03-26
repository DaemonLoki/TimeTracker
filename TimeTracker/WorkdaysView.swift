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
    
    @State private var selectedOption = 0
        
    var body: some View {
            VStack {
                Picker(selection: $selectedOption, label: Text("Choose")) {
                    Text("Days").tag(0)
                    Text("Weeks").tag(1)
                    //Text("Months").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color.offWhite)
                
                if self.selectedOption == 0 {
                    DaysListView(workdays: self.workdays, workday: self.workday, startTimeSet: self.$startTimeSet, endTimeSet: self.$endTimeSet
                    )
                } else if self.selectedOption == 1 {
                    Text("Coming soon")
                    Spacer()
                }
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
