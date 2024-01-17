//
//  Event.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//


import UIKit

class Event {
    var startTime: TimeInterval
    var endTime: TimeInterval
    var title: String
    var color: UIColor
    var description: String

    init(title: String, startTime: TimeInterval, endTime: TimeInterval, description: String,  color: UIColor) {
        self.title = title
        self.startTime = startTime
        self.endTime = endTime
        self.color = color
        self.description = description
    }
}
