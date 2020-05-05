//
//  PauseView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 30.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct PauseView: View {
    
    @ObservedObject var workday: Workday
    
    @State private var breakDuration = 0
    
    init(workday: Workday) {
        self.workday = workday
        self.breakDuration = Int(workday.breakDuration)
    }
    
    var body: some View {
        let breakBinding = Binding<Int>(
            get: {
                self.breakDuration
        }, set: {
            self.breakDuration = $0
            self.workday.breakDuration = Double($0)
        })
        return Stepper("Pause: \(Int(self.workday.breakDuration))", onIncrement: {
            breakBinding.wrappedValue = Int(self.workday.breakDuration) + 5
        }, onDecrement: {
            if self.workday.breakDuration >= 5 {
                breakBinding.wrappedValue = Int(self.workday.breakDuration) - 5
            }
        })
            .padding()
            .background(FancyBackground(shape: RoundedRectangle(cornerRadius: 10)))
            .padding()
    }
}

struct PauseView_Previews: PreviewProvider {
    static var previews: some View {
        PauseView(workday: .example)
    }
}
