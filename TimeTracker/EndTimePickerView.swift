//
//  EndTimePickerView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 30.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct EndTimePickerView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var workday: Workday
    
    let pickerHeight: CGFloat = 80
    
    var body: some View {
        let currentDate = Binding<Date>(
            get: {
                self.workday.unwrappedEnd
        },
            set: {
                self.workday.end = self.workday.start!.withHourAndMinute(from: $0)
                try? self.moc.save()
        }
        )
        
        return ZStack {
            Color.myBackground
            
            VStack {
                HStack(spacing: 20) {
                    Text("End")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    DatePicker(selection: currentDate, in: workday.unwrappedStart..., displayedComponents: .hourAndMinute) {
                        Text("Time")
                    }
                    .datePickerStyle(WheelDatePickerStyle())
                    .frame(width: 140, height: self.pickerHeight)
                    .padding()
                    .clipped()
                }
                .padding()
                .background(AdaptiveBackground(shape: RoundedRectangle(cornerRadius: .cornerRadius, style: .continuous)))
                .padding()
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.primary)
                    }
                    .buttonStyle(SimpleButtonStyle())
                }
            }
            .padding(.vertical, 40)
            .padding(.horizontal)
        }
    }
}

struct EndTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        EndTimePickerView(workday: .example)
    }
}
