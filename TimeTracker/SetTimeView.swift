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
    
    var workday: Workday
    
    var body: some View {
        ZStack {
            Color.offWhite
            
            ScrollView {
                VStack {
                    StartTimePickerView(workday: self.workday)
                    
                    EndTimePickerView(workday: self.workday)
                    
                    PauseView(workday: self.workday)
                    
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
            }
            .background(Color.offWhite)
            .navigationBarTitle(workday.start?.headlineString() ?? "Today")
        }
    }
    
    func calculateWorkTime() -> String {
        return workday.unwrappedEnd.difference(to: workday.unwrappedStart, with: Int(workday.breakDuration))
    }
    
    func saveWorkday() {
        try? self.moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct SetTimeView_Previews: PreviewProvider {
    static var previews: some View {
        SetTimeView(workday: Workday.example)
    }
}
