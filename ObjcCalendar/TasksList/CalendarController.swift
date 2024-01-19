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
        Event(id: 1, date_start: 1705575600, date_finish: 1705590000, name: "test", description: "blbalblb")
    }
    
    var numberOfEvents: Int {
        return self.events.count
    }
    
    func setEvents(_ newEvents: [Event]) {
            self.events = newEvents
        }

    func eventAtIndex(index: Int) -> Event {
        return self.events[index]
    }
    
    func clearEvents() {
            events.removeAll()
        }
    
    func addEvent(_ event: Event) {
            events.append(event)
        }
    
    
}
