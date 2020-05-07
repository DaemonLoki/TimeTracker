//
//  EditButton.swift
//  TimeTracker
//
//  Created by Stefan Blos on 06.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct EditButton<V: View>: View {
    
    var workday: Workday
    var destination: V
    
    @State private var currentOffset: CGFloat = 0
    @State private var currentScale: CGFloat = 0
    
    var body: some View {
        NavigationLink(destination: destination) {
            Image(systemName: "pencil")
                .foregroundColor(.white)
        }
        .padding(20)
        .contentShape(Circle())
        .background(AdaptiveBackground(shape: Circle(), backgroundColor: .codecampVeryDarkBlue))
        .offset(x: currentOffset, y: currentOffset)
        .scaleEffect(currentScale)
        .animation(.easeInOut)
        .onAppear {
            self.currentOffset = 98
            self.currentScale = 1
        }
    }
}

struct EditButton_Previews: PreviewProvider {
    static var previews: some View {
        EditButton(workday: .example, destination: EmptyView())
    }
}
