//
//  CalendarView.swift
//  TimeTracker
//
//  Created by Stefan Blos on 02.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.calendar) var calendar
    
    let setDays: Set<Date>
    
    private var months: [Date] {
        calendar.generateDates(inside: calendar.dateInterval(of: .year, for: Date())!, matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0))
    }
    
    var body: some View {
        ZStack {
            Color.myBackground
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(months, id: \.self) { month in
                        MonthView(month: month) { date in
                            Text("30")
                                .hidden()
                                .padding(8)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .padding(.vertical, 4)
                                .overlay(Text(String(self.calendar.component(.day, from: date))))
                            
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Select day to add")
    }
}

struct MonthView<DateView>: View where DateView: View{
    @Environment(\.calendar) var calendar
    
    let month: Date
    let content: (Date) -> DateView
    
    init(month: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.month = month
        self.content = content
    }
    
    private var weeks: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: month) else { return [] }
        
        return calendar.generateDates(inside: monthInterval, matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday))
    }
    
    var body: some View {
        VStack {
            Text(DateFormatter.month.string(from: month))
                .font(.title)
                .padding(.top, 30)
                .padding(.bottom, 10)
            
            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
            }
        }
    }
}

struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let week: Date
    let content: (Date) -> DateView
    
    init(week: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }
    
    private var days: [Date] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week) else { return [] }
        
        return calendar.generateDates(inside: weekInterval, matching: DateComponents(hour: 0, minute: 0, second: 0))
    }
    
    var body: some View {
        HStack {
            ForEach(days, id: \.self) { date in
                HStack {
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                    } else {
                        self.content(date).hidden()
                    }
                }
            }
        }
    }
}

fileprivate extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        
        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        
        return dates
    }
}

fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(setDays: Set<Date>())
    }
}
