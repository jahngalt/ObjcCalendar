//
//  EventModel.swift
//  ObjcCalendar
//
//  Created by mike on 22.01.24.
//

import RealmSwift

class EventModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var date_start: Date?
    @objc dynamic var date_finish: Date?
    @objc dynamic var name: String = ""
    @objc dynamic var descriptionText: String = ""
}
