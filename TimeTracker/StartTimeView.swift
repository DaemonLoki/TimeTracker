//
//  StartTimeView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 07.05.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct StartTimeView: View {
    
    @ObservedObject var workday: Workday
    
    @State private var showingSetter = false
    
    var body: some View {
        HStack {
            Button(action: {
                self.showingSetter = true
            }) {
                    VStack(alignment: .center, spacing: 5) {
                        Text("Start")
                            .foregroundColor(.secondary)
                            .font(.headline)
                        
                        Text(self.workday.startTime)
                            .foregroundColor(.primary)
                            .font(.headline)
                    }
                    
            }
            .buttonStyle(SimpleButtonStyle())
            .padding(20)
            
            Spacer()
                .frame(height: 4)
                .padding(.leading, -20)
                .background(LinearGradient.cocGradient)
        }
        .sheet(isPresented: $showingSetter) {
            StartTimePickerView(workday: self.workday)
        }
    }
}

struct StartTimeView_Previews: PreviewProvider {
    static var previews: some View {
        StartTimeView(workday: .example)
    }
}
