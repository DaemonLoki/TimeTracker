//
//  GraphView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 29.05.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct GraphView: View {
    
    var points: [Double]
    @State private var drawing = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Path { path in
                    let height = geo.size.height
                    let heightUnit = height / 12.0
                    
                    path.move(
                        to: CGPoint(
                            x: 0,
                            y: 100
                        )
                    )
                    
                    for i in 0..<self.points.count - 1 {
                        let x: CGFloat = CGFloat((geo.size.width / CGFloat(self.points.count - 2)) * CGFloat(i))
                        let y: CGFloat = height - (CGFloat(self.points[i]) * heightUnit)
                        
                        if i == 0 {
                            path.move(to: .init(x: x, y: y))
                        } else {
                            path.addLine(to: .init(x: x, y: self.drawing ? y : height))
                        }
                    }
                    
                }
                .stroke(Color.white, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                
                
                Path { path in
                    let height = geo.size.height
                    let heightUnit = height / 12.0
                    
                    path.move(
                        to: CGPoint(
                            x: 0,
                            y: geo.size.height
                        )
                    )
                    
                    for i in 0..<self.points.count - 1 {
                        let x: CGFloat = CGFloat((geo.size.width / CGFloat(self.points.count - 2)) * CGFloat(i))
                        let y: CGFloat = height - (CGFloat(self.points[i]) * heightUnit)
                        
                        path.addLine(to: .init(x: x, y: self.drawing ? y : height))
                    }
                    
                    path.addLine(to: .init(x: geo.size.width, y: geo.size.height))
                    
                }
                .fill(Color.white)
                .opacity(0.11)
            }
            
        }
        .onAppear {
            withAnimation(Animation.interactiveSpring().delay(2).speed(0.2)) {
                self.drawing = true
            }
        }
        
    }
    
}


struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(points: [2.3, 7.3, 8.2, 7.5, 6.3])
            .background(LinearGradient.cocGradient)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding()
    }
}
