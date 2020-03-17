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
    @Binding var breakDuration: Double
    
    @State private var startHours: Int = 0
    
    let pickerHeight: CGFloat = 80
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.offWhite
                
                VStack {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 40) {
                            Text("Start")
                                .font(.headline)
                                .frame(width: 80)
                            
                            DatePicker(selection: self.$startDate, in: ...self.endDate, displayedComponents: .hourAndMinute) {
                                Text("Start")
                            }
                            .datePickerStyle(WheelDatePickerStyle())
                            .frame(width: 140, height: self.pickerHeight)
                            .padding()
                            .clipped()
                        }
                        
                        HStack(spacing: 40) {
                            Text("End")
                                .font(.headline)
                                .frame(width: 80)
                            
                            DatePicker(selection: self.$endDate, in: self.startDate..., displayedComponents: .hourAndMinute) {
                                Text("End")
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
                    
                    Stepper("Pause: \(Int(self.breakDuration))", onIncrement: {
                            self.breakDuration += 5
                    }, onDecrement: {
                            if self.breakDuration >= 5 {
                                self.breakDuration -= 5
                            }
                    })
                        .padding()
                        .background(FancyBackground(shape: RoundedRectangle(cornerRadius: 10)))
                        .padding(.horizontal)
                    
                    HStack {
                        Text(self.calculateWorkTime())
                            .font(.largeTitle)
                            .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            self.saveWorkday()
                        }) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.primary)
                        }
                        .buttonStyle(SimpleButtonStyle())
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical)
                    
                }
                .frame(width: geo.size.width)
                .background(Color.offWhite)
                .navigationBarTitle("Change times")
            }
        }
    }
    
    func calculateWorkTime() -> String {
        return self.endDate.difference(to: self.startDate, with: Int(self.breakDuration))
    }
    
    func saveWorkday() {
        guard let day = self.workday else { return }
        day.start = self.startDate
        day.end = self.endDate
        day.breakDuration = Double(self.breakDuration)
        try? self.moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct SetTimeView_Previews: PreviewProvider {
    static var previews: some View {
        SetTimeView(startDate: Binding.constant(Date()), endDate: Binding.constant(Date()), workday: Binding.constant(nil), breakDuration: Binding.constant(10))
    }
}
