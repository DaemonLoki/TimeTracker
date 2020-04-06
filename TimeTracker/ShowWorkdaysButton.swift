//
//  ShowWorkdaysButton.swift
//  TimeTracker
//
//  Created by Stefan Blos on 06.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ShowWorkdaysButton: View {
    
    @Binding var startTimeSet: Bool
    @Binding var endTimeSet: Bool
    @Binding var workDay: Workday?
    
    var body: some View {
        NavigationLink(destination: WorkdaysView(startTimeSet: $startTimeSet, endTimeSet: $endTimeSet, currentWorkday: $workDay)) {
            Image(systemName: "list.bullet")
        }
        .buttonStyle(SimpleButtonStyle())
    }
}

struct ShowWorkdaysButton_Previews: PreviewProvider {
    static var previews: some View {
        ShowWorkdaysButton(startTimeSet: Binding.constant(true), endTimeSet: Binding.constant(false), workDay: Binding.constant(nil))
    }
}
