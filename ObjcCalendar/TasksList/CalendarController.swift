//
//  CalendarController.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//

import UIKit

class CalendarController {
    
    private var events: [Event] = []
    private var filteredTasks: [TaskModel] = []
    init() {
        // Mock a few events for the day
            self.events = [
                Event(title: "Сходить в магазин", startTime: 1705496400, endTime: 1705505400, description: "купить продукты", color: .blue),
                Event(title: "Учить iOS", startTime: 1705480200, endTime: 1705483800, description: "купить продукты", color: .blue),
                Event(title: "Учить iOS", startTime: 1705568400, endTime: 1705572000, description: "купить продукты", color: .blue)
               
            ]
    }

    var numberOfEvents: Int {
        return self.events.count
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
