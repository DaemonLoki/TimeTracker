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
    
    @ObservedObject var workday: Workday
    
    @State private var endAngle: Double = 0
    
    var body: some View {
        let durBinding = Binding<Double>(
            get: {
                self.workday.workDur
        }, set: {
            print("Is set to \($0)")
        })
        return ZStack {
            Color.myBackground
            
            ScrollView {
                VStack {
                    StartTimeView(workday: self.workday)
                    
                    EndTimeView(workday: self.workday)
                    
                    PauseView(workday: self.workday)
                    
                    HStack {
                        Text(self.workday.workDurationString)
                            .font(.subheadline)
                            .foregroundColor(.codecampVeryDarkBlue)
                            .frame(width: 60)
                            .padding(.vertical, 20)
                            .background(
                                Arc(endAngle: durBinding.wrappedValue)
                                    .stroke(LinearGradient(Color.codecampVeryDarkBlue, Color.codecampLessDarkBlue, Color.codecampABitLightBlue, Color.codecampReallyLightBlue), style: StrokeStyle(lineWidth: 6, lineCap: .round))
                                    .animation(.interpolatingSpring(mass: 1, stiffness: 25, damping: 8, initialVelocity: 1))
                            )
                            .padding(15)
                            .background(AdaptiveBackground(shape: Circle(), isHighlighted: true))
                        
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
            .background(Color.myBackground)
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
