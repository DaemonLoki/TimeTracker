//
//  Date+Extension.swift
//  TimeTracker
//
//  Created by Stefan Blos on 11.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import Foundation

extension Date {
    
    func hourString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
    
    func headlineString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    func difference(to date: Date, with breakDuration: Int = 0) -> String {
        let timeInterval = self.timeIntervalSince(date) - Double(breakDuration * 60)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        
        //formatter.dateFormat = "HH:mm"
        guard let hourString = formatter.string(from: timeInterval) else { return "0:00 h"}
        return hourString
    }
    
    func getWeekOfYear() -> Int {
        let calendar = Calendar.current
        return calendar.component(.weekOfYear, from: self)
    }
    
    func getYear() -> Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }
    
    func getDayOfWeek() -> Int {
        let calendar = Calendar.current
        return calendar.component(.weekday, from: self)
    }
    
    func getNameOfWeekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    func withHourAndMinute(from date: Date) -> Date {
        let hour = Calendar.current.component(.hour, from: date)
        let minute = Calendar.current.component(.minute, from: date)
        
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: self) ?? Date()
    }
}
