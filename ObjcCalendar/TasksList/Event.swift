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
        self.color = UIColor.randomColor()
        self.description = description
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
