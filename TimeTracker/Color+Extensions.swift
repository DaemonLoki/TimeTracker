//
//  Color+Extensions.swift
//  TimeTracker
//
//  Created by Stefan Blos on 12.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    
    //static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    
    static let codecampVeryDarkBlue = Color(red: 0 / 255, green: 114 / 255, blue: 141 / 255)
    static let codecampLessDarkBlue = Color(red: 53 / 255, green: 144 / 255, blue: 166 / 255)
    static let codecampABitLightBlue = Color(red: 104 / 255, green: 174 / 255, blue: 191 / 255)
    static let codecampReallyLightBlue = Color(red: 151 / 255, green: 203 / 255, blue: 214 / 255)
    
    static let myBackground = Color("myBackground")
    
    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
}


extension UIColor {
    
    //static let offWhite = UIColor(red: 225 / 255, green: 225 / 255, blue: 235 / 255, alpha: 1)
    static let myBackground = UIColor(named: "myBackground")
}
