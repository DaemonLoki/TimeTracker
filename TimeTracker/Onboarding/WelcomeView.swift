//
//  WelcomeView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 30.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height + 30
    }
    
    var body: some View {
        ZStack {
            Color.offWhite
                
                VStack(spacing: 20) {
                    Text("Welcome")
                        .font(.largeTitle)
                    
                    Text("We want to help you keep track of your time better.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(40)
                    
                    Text("See how much you work and know when it is okay to take a break.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(40)
                    
                    Spacer()
                    
                    Button(action: {
                        let workday = Workday(context: self.moc)
                        workday.start = Date()
                        
                        try? self.moc.save()
                    }) {
                        Text("Start")
                    }
                    .buttonStyle(SimpleButtonStyle())
                    .padding(40)
                }
                .padding(.top, statusBarHeight)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
