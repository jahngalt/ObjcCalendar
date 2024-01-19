import UIKit

class EventService {
    static let shared = EventService()
    
    private init() {}
    
    func fetchEvents(forDate date: Date, completion: @escaping ([Event]?) -> Void) {
        if let path = Bundle.main.path(forResource: "tasks", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                do {
                    let events = try decoder.decode([Event].self, from: data)
                    let calendar = Calendar.current

                    // Приведение целевой даты к началу дня
                    let targetDateStart = calendar.startOfDay(for: date)

                    let filteredEvents = events.filter { event in
                        // Приведение дат начала и окончания события к началу дней
                        let eventStartDate = calendar.startOfDay(for: Date(timeIntervalSince1970: event.date_start))
                        let eventEndDate = calendar.startOfDay(for: Date(timeIntervalSince1970: event.date_finish))
                        print("EventStartDate: ", eventStartDate)
                        print("EventEndDate:  ", eventEndDate)
                        print("TargetDateStart: ", targetDateStart)
                        // Сравнение дат без учета времени
                        return eventStartDate <= targetDateStart && eventEndDate >= targetDateStart
                        
                        
                    }
                    
                    

                    completion(filteredEvents)
                } catch {
                    print("Ошибка при декодировании JSON: \(error.localizedDescription)")
                    completion(nil)
                }

            } catch {
                print("Ошибка при загрузке данных из файла: \(error.localizedDescription)")
                completion(nil)
            }
        } else {
            print("Файл JSON не найден в корне проекта")
            completion(nil)
        }
    }
}
