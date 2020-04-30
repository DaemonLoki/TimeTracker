//
//  HomeView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 29.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    var workday: Workday
    var fetchedResults: FetchedResults<Workday>
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.offWhite
                
                VStack {
                    ZStack {
                        TodayTimeView(workday: workday)
                    
                        if workday.startTimeSet {
                            EditButton(workday: workday)
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        ShowWorkdaysButton(workDay: workday)
                        
                        Spacer()
                        
                        AddTimeButton(workday: workday)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Time Tracker")
        }
        .accentColor(.codecampVeryDarkBlue)
    }
}

/*
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(workday: Workday.example, fetchedResults: FetchedResults<Workday>())
    }
}
 */