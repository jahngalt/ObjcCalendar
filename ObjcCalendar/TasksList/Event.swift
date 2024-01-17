//
//  Event.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//


import UIKit

class Event {
    var timespan: NSRange
    var title: String
    var color: UIColor

    init(title: String, timespan: NSRange, color: UIColor) {
        self.title = title
        self.timespan = timespan
        self.color = color
    }
}
