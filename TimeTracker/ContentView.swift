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
    
    var body: some View {
        FetchedWorkday { (workday: Workday, workdays: FetchedResults<Workday>) in
            HomeView(workday: workday, fetchedResults: workdays)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
