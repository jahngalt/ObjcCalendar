////
////  CalendarHelper.swift
////  CalendarApp
////
////  Created by mike on 12.01.24.
////
//
import UIKit



class CalendarHelper {
    let calendar: Calendar
    
    init() {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 // Понедельник
        self.calendar = calendar
    }

    

    func daysInMonth(date: Date)  -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func firstOfMonth(date: Date) -> Date {
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.day = 1
        return calendar.date(from: components)!
    }
    
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return (components.weekday! - calendar.firstWeekday + 7) % 7
    }
    
    
    func yearString(date: Date) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy"
           return dateFormatter.string(from: date)
       }
    
    
       func monthString(date: Date) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "LLLL"
           return dateFormatter.string(from: date)
       }
    
    func plusMonth(date: Date) -> Date {
            return calendar.date(byAdding: .month, value: 1, to: date)!
        }
    
        func minusMonth(date: Date) -> Date {
            return calendar.date(byAdding: .month, value: -1, to: date)!
        }
}
