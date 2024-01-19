//
//  CommonVC.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//

import UIKit



class CommonVC: UIViewController, CalendarDelegate {
    
    var vcCalendar = ViewControllerCalendar()
    var calendarController = CalendarViewController()
    
    let eventService = EventService.shared
    
    let addTaskButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentNewController))
    
    @objc func presentNewController() {
        
    }
    
    override func viewDidLoad() {
        vcCalendar.delegate = self
        
        navigationItem.rightBarButtonItem = addTaskButton
    }
    
    func didSelectDate(_ date: Date) {
        eventService.fetchEvents(forDate: date) { events in
            if let events = events {
                print("recieved events: \(events)")
                self.calendarController.displayEvents(events)
            } else {
                print("error ")
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "CalendarSegue" {
               if let calendarVC = segue.destination as? ViewControllerCalendar {
                   self.vcCalendar = calendarVC
               }
           } else if segue.identifier == "EventsListSegue" {
               if let eventsListVC = segue.destination as? CalendarViewController {
                   self.calendarController = eventsListVC
               }
           }
       }
    
    
    
}
