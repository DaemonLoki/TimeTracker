//
//  DaysListView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 26.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct DaysListView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var workdays: FetchedResults<Workday>
    var workday: Workday?
    @Binding var startTimeSet: Bool
    @Binding var endTimeSet: Bool
    
    var body: some View {
        List {
            ForEach(self.workdays, id: \.self) { (workday: Workday) in
                WorkdayCardView(workday: workday)
                    .listRowBackground(Color.offWhite)
            }
            .onDelete(perform: removeDay)
            .background(Color.offWhite)
            
        }
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

/*
struct DaysListView_Previews: PreviewProvider {
    static var previews: some View {
        DaysListView()
    }
}
*/
