//
//  StartTimePickerView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 30.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct StartTimePickerView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var workday: Workday
    
    let pickerHeight: CGFloat = 80
        
    var body: some View {
        let currentDate = Binding<Date>(
            get: {
                self.workday.unwrappedStart
            },
            set: {
                self.workday.start = $0
                try? self.moc.save()
            }
        )
        
        return HStack(spacing: 20) {
            Text("Start")
                .font(.headline)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            DatePicker(selection: currentDate, in: ...workday.unwrappedEnd, displayedComponents: .hourAndMinute) {
                Text("Time")
            }
            .datePickerStyle(WheelDatePickerStyle())
            .frame(width: 140, height: self.pickerHeight)
            .padding()
            .clipped()
        }
        .padding()
        .background(AdaptiveBackground(shape: RoundedRectangle(cornerRadius: 10)))
        .padding()    
    }
}

struct StartTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        StartTimePickerView(workday: .example)
    }
}
