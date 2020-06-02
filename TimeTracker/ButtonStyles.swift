//
//  ButtonStyles.swift
//  TimeTracker
//
//  Created by Stefan Blos on 12.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import Foundation
import SwiftUI

struct LightBackground<S: Shape>: View {
    var shape: S
    var isHighlighted: Bool = false
    var backgroundColor: Color = .myBackground
    
    var body: some View {
        Group {
            if isHighlighted {
                shape
                    .fill(backgroundColor)
                    .overlay(
                        shape
                            .stroke(Color.gray, lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(shape.fill(LinearGradient(Color.black, Color.clear)))
                )
                    .overlay(
                        shape
                            .stroke(Color.white, lineWidth: 8)
                            .blur(radius: 4)
                            .offset(x: -2, y: -2)
                            .mask(shape.fill(LinearGradient(Color.clear, Color.black))))
            } else {
                shape
                    .fill(backgroundColor)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            }
        }
    }
}

struct DarkBackground<S: Shape>: View {
    var shape: S
    var isHighlighted: Bool
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                    //.overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    //.overlay(shape.stroke(Color.darkEnd, lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct AdaptiveBackground<S: Shape>: View {
    var shape: S
    var isHighlighted: Bool = false
    var backgroundColor: Color = .myBackground
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Group {
            if colorScheme == .light {
                LightBackground(shape: shape, isHighlighted: isHighlighted, backgroundColor: backgroundColor)
            } else {
                DarkBackground(shape: shape, isHighlighted: isHighlighted)
            }
        }
    }
}

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                AdaptiveBackground(shape: Circle(), isHighlighted: configuration.isPressed)
        )
    }
}

struct ButtonStyles_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                Color.myBackground
                
                VStack {
                    AdaptiveBackground(shape: Circle())
                        .frame(width: 200, height: 200)
                        .padding()
                    
                    AdaptiveBackground(shape: Circle(), isHighlighted: true)
                        .frame(width: 200, height: 200)
                        .padding()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .environment(\.colorScheme, .light)
            
            ZStack {
                Color.myBackground
                
                VStack {
                    AdaptiveBackground(shape: RoundedRectangle(cornerRadius: .cornerRadius, style: .continuous))
                        .frame(width: 200, height: 200)
                        .padding()
                    
                    AdaptiveBackground(shape: RoundedRectangle(cornerRadius: .cornerRadius, style: .continuous), isHighlighted: true)
                        .frame(width: 200, height: 200)
                        .padding()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .environment(\.colorScheme, .dark)
        }
    }
}
