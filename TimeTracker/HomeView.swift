//
//  HomeView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 29.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @ObservedObject var workday: Workday
    var fetchedResults: FetchedResults<Workday>
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.myBackground
                
                VStack {
                    ZStack {
                        TodayTimeView(workday: fetchedResults.first ?? workday)
                    
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
