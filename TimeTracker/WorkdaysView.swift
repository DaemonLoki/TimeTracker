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
    
    @FetchRequest(entity: Workday.entity(), sortDescriptors: []) var workdays: FetchedResults<Workday>
    
    var body: some View {
        List {
            ForEach(self.workdays, id: \.self) { (workday: Workday) in
                WorkdayCardView(workday: workday)
            }
        }
    .navigationBarTitle("Your workdays")
    }
}

struct WorkdaysView_Previews: PreviewProvider {
    static var previews: some View {
        WorkdaysView()
    }
}
