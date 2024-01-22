import UIKit
import RealmSwift

class EventService {
    static let shared = EventService()

    private init() {}

    func fetchEvents(forDate date: Date, completion: @escaping ([EventModel]?) -> Void) {
        let realm = try! Realm()

        let calendar = Calendar.current
        let targetDateStart = calendar.startOfDay(for: date)
        let targetDateEnd = calendar.date(byAdding: .day, value: 1, to: targetDateStart)!

        let events = Array(realm.objects(EventModel.self).filter("date_start >= %@ AND date_start < %@", targetDateStart, targetDateEnd))
        completion(events)
    }
}
