//
//  EndTimeView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 07.05.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct EndTimeView: View {
    
    @ObservedObject var workday: Workday
    
    @State private var showingSetter = false
    
    var body: some View {
        HStack {
            Spacer()
                .frame(height: 4)
                .background(LinearGradient.cocGradient)
            
            Button(action: {
                self.showingSetter = true
            }) {
                VStack(alignment: .center, spacing: 5) {
                    Text("End")
                        .foregroundColor(.secondary)
                        .font(.headline)
                    
                    Text(self.workday.endTime)
                        .foregroundColor(.primary)
                        .font(.headline)
                }
                
            }
            .buttonStyle(SimpleButtonStyle())
            .padding(20)
        }
        .sheet(isPresented: $showingSetter) {
            EndTimePickerView(workday: self.workday)
        }
    }
}

struct EndTimeView_Previews: PreviewProvider {
    static var previews: some View {
        EndTimeView(workday: .example)
    }
}
