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
            VStack {
                
                HStack(alignment: .center, spacing: 20) {
                    VStack {
                        Text("Start time")
                            .font(.title)
                        DatePicker(selection: self.$startDate, in: ...self.endDate, displayedComponents: .hourAndMinute) {
                            Text("")
                        }
                        .datePickerStyle(WheelDatePickerStyle())
                        .frame(width: 100, height: 150)
                        .padding()
                    }
                    
                    VStack {
                        Text("End time")
                            .font(.title)
                        
                        DatePicker(selection: self.$endDate, in: self.startDate..., displayedComponents: .hourAndMinute) {
                            Text("")
                        }
                        .datePickerStyle(WheelDatePickerStyle())
                        .frame(width: 100, height: 150)
                        .padding()
                    }
                }
                .padding(40)
                
                Text(self.endDate.difference(to: self.startDate))
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    guard let day = self.workday else { return }
                    day.start = self.startDate
                    day.end = self.endDate
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.primary)
                }
                    .buttonStyle(SimpleButtonStyle())
                    .padding(40)
                    
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
