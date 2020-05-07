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
    
    @State private var currentDate = Date()
    
    var body: some View {
        FetchedWorkday(currentDate: self.currentDate) { (workday: Workday, workdays: FetchedResults<Workday>) in
            HomeView(workday: workday, fetchedResults: workdays)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { (_) in
            self.currentDate = Date()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
