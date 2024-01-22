//
//  CommonVC.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//

import UIKit

class CommonVC: UIViewController, CalendarDelegate {

    var vcCalendar = ViewControllerCalendar()
    var calendarController = TimeLineViewController()

    let eventService = EventService.shared

    override func viewDidLoad() {
        vcCalendar.delegate = self

        let addTaskButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddTaskViewController))
        navigationItem.rightBarButtonItem = addTaskButton
        navigationItem.title = "Calendar App"

    }

    @objc func presentAddTaskViewController() {
        let vc = AddTaskViewController()
        present(vc, animated: true)
    }

    func didSelectDate(_ date: Date) {
        eventService.fetchEvents(forDate: date) { events in
            if let events = events {
                print("recieved events: \(events)")
                self.calendarController.displayEvents(forDate: date)
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
               if let eventsListVC = segue.destination as? TimeLineViewController {
                   self.calendarController = eventsListVC
               }
           }
       }

}
