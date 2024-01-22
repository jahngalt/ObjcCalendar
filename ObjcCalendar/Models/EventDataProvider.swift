//
//  CalendarController.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//

import UIKit

class EventDataProvider {
    private var events: [EventModel] = []

    var numberOfEvents: Int {
        return self.events.count
    }

    func setEvents(_ newEvents: [EventModel]) {
            self.events = newEvents
        }

    func eventAtIndex(index: Int) -> EventModel {
        return self.events[index]
    }

    func clearEvents() {
            events.removeAll()
        }

    func addEvent(_ event: EventModel) {
            events.append(event)
        }
}
