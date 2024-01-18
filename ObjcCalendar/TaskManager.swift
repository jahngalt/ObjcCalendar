//
//  TaskManager.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//

import Foundation

class TaskManager {
    static let shared = TaskManager()
    
    private var tasks: [TaskModel] = []
    
    func loadTaskFromJSON() {
        if let path = Bundle.main.path(forResource: "tasks", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                tasks = try decoder.decode([TaskModel].self, from: data)
            } catch {
                print("Ошибка при загрузке и декодировании JSON: \(error)")
            }
        }
        
        print(tasks)
    }
    
    func getTasks() -> [TaskModel] {
        return tasks
    }
    
    func filterTasks(forDate date: Date) -> [TaskModel] {
        return tasks.filter { task in
            let taskStartDate = Date(timeIntervalSince1970: task.date_start)
            let taskEndDate = Date(timeIntervalSince1970: task.date_finish)
            return date >= taskStartDate && date <= taskEndDate
        }
    }

}
