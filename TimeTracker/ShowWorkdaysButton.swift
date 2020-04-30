//
//  ShowWorkdaysButton.swift
//  TimeTracker
//
//  Created by Stefan Blos on 06.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ShowWorkdaysButton: View {
    
    var workDay: Workday
    
    var body: some View {
        NavigationLink(destination: WorkdaysView(currentWorkday: workDay)) {
            Image(systemName: "list.bullet")
        }
        .buttonStyle(SimpleButtonStyle())
    }
}

struct ShowWorkdaysButton_Previews: PreviewProvider {
    static var previews: some View {
        ShowWorkdaysButton(workDay: .example)
    }
}
