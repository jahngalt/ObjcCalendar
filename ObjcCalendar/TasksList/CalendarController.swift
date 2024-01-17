//
//  CalendarController.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//

import UIKit

class CalendarController {
    private var events: [Event] = []

    init() {
        // Mock a few events for the day
        self.events = [
            Event(title: "Late snack", timespan: NSRange(location: 3600, length: 1800), color: .red),
            Event(title: "Breakfast with Nancy", timespan: NSRange(location: 23400, length: 3600), color: .blue),
            Event(title: "Shopping for a much-needed new pair of shoes", timespan: NSRange(location: 32400, length: 10800), color: .red),
            Event(title: "Meeting!", timespan: NSRange(location: 52200, length: 7200), color: .orange),
            Event(title: "Beer with Matt", timespan: NSRange(location: 75600, length: 10800), color: .blue)
        ]
    }

    var numberOfEvents: Int {
        return self.events.count
    }

    func eventAtIndex(index: Int) -> Event {
        return self.events[index]
    }
}
