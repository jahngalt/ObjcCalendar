//
//  TaskModel.swift
//  CalendarApp
//
//  Created by mike on 15.01.24.
//

import Foundation

struct TaskModel: Codable {
    let id: Int
    let date_start: TimeInterval
    let date_finish: TimeInterval
    let name: String
    let description: String
}
