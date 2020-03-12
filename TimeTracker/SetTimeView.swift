//
//  SetTimeView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 11.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct SetTimeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var moc
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var workday: Workday?
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                Text("Start time")
                    .font(.title)
                DatePicker(selection: self.$startDate, in: ...self.endDate, displayedComponents: .hourAndMinute) {
                    Text("")
                }
                .datePickerStyle(WheelDatePickerStyle())
                .frame(width: 200, height: 150)
                .padding()
                
                Text("End time")
                    .font(.title)
                
                DatePicker(selection: self.$endDate, in: self.startDate..., displayedComponents: .hourAndMinute) {
                    Text("")
                }
                .datePickerStyle(WheelDatePickerStyle())
                .frame(width: 200, height: 150)
                .padding()
                
                Spacer()
                
                Button("Confirm") {
                    print("selected: \(self.startDate)")
                    guard let day = self.workday else { return }
                    day.start = self.startDate
                    day.end = self.endDate
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .frame(width: geo.size.width)
            .background(Color.offWhite)
        .navigationBarTitle("Change times")
        }
    }
}

/*
struct SetTimeView_Previews: PreviewProvider {
    static var previews: some View {
        SetTimeView()
    }
}
 */
