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
    
    @State private var headlineOpacity = 0.0
    @State private var headlineScale: CGFloat = 0.8
    
    @State private var subtext1Opacity = 0.0
    @State private var subtext1Scale: CGFloat = 0.7
    
    @State private var subtext2Opacity = 0.0
    @State private var subtext2Scale: CGFloat = 0.7
    
    @State private var buttonOpacity = 0.0
    @State private var buttonScale: CGFloat = 0.5
    
    var body: some View {
        ZStack {
            Color.offWhite
            
            VStack(spacing: 20) {
                Text("Welcome")
                    .font(.largeTitle)
                    .scaleEffect(headlineScale)
                    .opacity(headlineOpacity)
                
                Text("We want to help you keep track of your time better.")
                    .font(.headline)
                    .scaleEffect(subtext1Scale)
                    .opacity(subtext1Opacity)
                    .multilineTextAlignment(.center)
                    
                    .padding(40)
                
                Text("See how much you work and know when it is okay to take a break.")
                    .font(.body)
                    
                    .scaleEffect(subtext2Scale)
                    .opacity(subtext2Opacity)
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
                .scaleEffect(buttonScale)
                .opacity(buttonOpacity)
                .padding(40)
            }
            .padding(.top, statusBarHeight)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(.easeIn(duration: 0.8)) {
                self.headlineOpacity = 1.0
                self.headlineScale = 1.0
            }
            
            withAnimation(Animation.easeInOut(duration: 0.8).delay(0.2)) {
                self.subtext1Opacity = 1.0
                self.subtext1Scale = 1.0
            }
            
            withAnimation(Animation.easeInOut(duration: 0.8).delay(0.4)) {
                self.subtext2Opacity = 1.0
                self.subtext2Scale = 1.0
            }
            
            withAnimation(Animation.easeInOut(duration: 0.8).delay(1)) {
                self.buttonOpacity = 1.0
                self.buttonScale = 1.0
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
