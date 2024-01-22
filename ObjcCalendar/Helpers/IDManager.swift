//
//  IDManager.swift
//  ObjcCalendar
//
//  Created by mike on 22.01.24.
//

import Foundation

class IDManager {
    static let shared = IDManager()

    private var currentID: Int = 0

    private init() {
        currentID = UserDefaults.standard.integer(forKey: "currentID")
    }

    func getUniqueID() -> Int {
        currentID += 1
        UserDefaults.standard.set(currentID, forKey: "currentID")
        return currentID
    }
}
