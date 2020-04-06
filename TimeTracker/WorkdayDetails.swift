//
//  WorkdayDetails.swift
//  TimeTracker
//
//  Created by Stefan Blos on 06.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct WorkdayDetails: View {
    
    var dayOfWeek: String
    var dateString: String
    var startTime: String
    var endTime: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                
                Text(dateString)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(Capsule().fill(Color.codecampLessDarkBlue))
                
            }
            .padding(.bottom, 10)
            
            Text(dayOfWeek.uppercased())
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 4)
            
            HStack {
                Text(startTime)
                    .font(.system(size: 24.0))
                    .foregroundColor(.primary)
                
                Text("-")
                    .foregroundColor(.secondary)
                
                Text(endTime)
                    .font(.system(size: 24.0))
                    .foregroundColor(.primary)
            }
            
            HStack {
                Image(systemName: "pause.circle")
                    .foregroundColor(.secondary)
                
                Text("1:22")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct WorkdayDetails_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Circle()
                .frame(width: 100, height: 100)
                .padding()
            
            WorkdayDetails(dayOfWeek: "Wednesday", dateString: "06.04.2020", startTime: "08:02", endTime: "17:44")
            .padding()
        }
        .background(FancyBackground(shape: RoundedRectangle(cornerRadius: 10)))
    }
}
