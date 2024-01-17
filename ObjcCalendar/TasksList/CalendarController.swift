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
                Event(title: "Сходить в магазин", startTime: 1705496400, endTime: 1705503600, description: "купить продукты", color: .blue),
               
            ]
    }

    var numberOfEvents: Int {
        return self.events.count
    }

    func eventAtIndex(index: Int) -> Event {
        return self.events[index]
    }
}
