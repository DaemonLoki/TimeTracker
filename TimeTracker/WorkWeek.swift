//
//  WorkWeek.swift
//  TimeTracker
//
//  Created by Stefan Blos on 26.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import Foundation

struct WorkWeek: Hashable {
    var weekOfYear: Int
    var year: Int
    var workdays: [Workday]
}
