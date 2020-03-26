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
    var dateRangeThrough: PartialRangeThrough<Date>?
    var dateRangeTo: PartialRangeFrom<Date>?
    
    
    let pickerHeight: CGFloat = 80
    
    var body: some View {
        HStack(spacing: 40) {
            Text("Start")
                .font(.headline)
                .frame(width: 80)
            
            Spacer()
            
            if dateRangeThrough != nil {
                DatePicker(selection: self.$selectionDate, in: dateRangeThrough!, displayedComponents: .hourAndMinute) {
                    Text("Start")
                    }
                    .datePickerStyle(WheelDatePickerStyle())
                    .frame(width: 140, height: self.pickerHeight)
                    .padding()
                    .clipped()
            } else {
                DatePicker(selection: self.$selectionDate, in: dateRangeTo!, displayedComponents: .hourAndMinute) {
                Text("Start")
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
            
            TimePickerView(selectionDate: Binding.constant(Date()), dateRangeThrough: ...Date())
        }
        .edgesIgnoringSafeArea(.all)
    }
}
