//
//  TimePickerView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 26.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct TimePickerView: View {
    
    @Binding var selectionDate: Date
    var title: String
    var dateRangeThrough: PartialRangeThrough<Date>?
    var dateRangeTo: PartialRangeFrom<Date>?
    
    
    let pickerHeight: CGFloat = 80
    
    var body: some View {
        HStack(spacing: 20) {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            if dateRangeThrough != nil {
                DatePicker(selection: self.$selectionDate, in: dateRangeThrough!, displayedComponents: .hourAndMinute) {
                    Text("Time")
                }
                .datePickerStyle(WheelDatePickerStyle())
                .frame(width: 140, height: self.pickerHeight)
                .padding()
                .clipped()
            } else {
                DatePicker(selection: self.$selectionDate, in: dateRangeTo!, displayedComponents: .hourAndMinute) {
                    Text("Time")
                }
                .datePickerStyle(WheelDatePickerStyle())
                .frame(width: 140, height: self.pickerHeight)
                .padding()
                .clipped()
            }
        }
        .padding()
        .background(FancyBackground(shape: RoundedRectangle(cornerRadius: 10)))
        .padding()
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
            
            TimePickerView(selectionDate: Binding.constant(Date()), title: "Start", dateRangeThrough: ...Date())
        }
        .edgesIgnoringSafeArea(.all)
    }
}
