import UIKit
import RealmSwift

class TimeLineViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CalendarViewLayoutDelegate {
    var events: [EventModel] = []
    var selectedDate = Date()

    func displayEvents(forDate selectedDate: Date) {
        let realm = try! Realm()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!

        let startOfDay = calendar.startOfDay(for: selectedDate)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

        let filteredEvents = Array(realm.objects(EventModel.self).filter("date_start >= %@ AND date_start < %@", startOfDay, endOfDay))

        self.calendarController.setEvents(filteredEvents)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    var calendarController: EventDataProvider!
    var collectionView: UICollectionView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
           super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
           self.calendarController = EventDataProvider()
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           self.calendarController = EventDataProvider()
       }

    override func viewDidLoad() {
        super.viewDidLoad()

       NotificationCenter.default.addObserver(self, selector: #selector(newTaskAdded), name: NSNotification.Name("NewTaskAdded"), object: nil)
    }

   @objc func newTaskAdded() {
       if Calendar.current.isDateInToday(selectedDate) {
           displayEvents(forDate: selectedDate)
       }
    }
    
    override func loadView() {
        let layout = CalendarViewLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.view = self.collectionView
        self.collectionView.register(EventViewCell.self, forCellWithReuseIdentifier: "event")
        self.collectionView.register(HourReusableView.self, forSupplementaryViewOfKind: "hour", withReuseIdentifier: "hour")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.calendarController.numberOfEvents
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "event", for: indexPath) as! EventViewCell
        cell.event = self.calendarController.eventAtIndex(index: indexPath.item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "hour", for: indexPath) as! HourReusableView
        view.setTime(time: "\(indexPath.item):00")
        view.isUserInteractionEnabled = false
        return view
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = self.calendarController.eventAtIndex(index: indexPath.item)
        showEventDetails(event: event)
    }

    func showEventDetails(event: EventModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        var message = event.descriptionText
        if let startDate = event.date_start, let endDate = event.date_finish {
            let startTime = dateFormatter.string(from: startDate)
            let endTime = dateFormatter.string(from: endDate)
            message += "\nStart Time: \(startTime)\nEnd Time: \(endTime)"
        }


        let alertController = UIAlertController(title: event.name, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    func calendarViewLayout(_ layout: CalendarViewLayout, startTimeForCellAt indexPath: IndexPath) -> TimeInterval {
        let event = self.calendarController.eventAtIndex(index: indexPath.item)
        let eventStartDate = Date(timeIntervalSince1970: event.date_start!.timeIntervalSince1970)
        let startOfDay = Calendar.current.startOfDay(for: eventStartDate)
        return eventStartDate.timeIntervalSince1970 - startOfDay.timeIntervalSince1970
    }

    func calendarViewLayout(_ layout: CalendarViewLayout, endTimeForCellAt indexPath: IndexPath) -> TimeInterval {
        let event = self.calendarController.eventAtIndex(index: indexPath.item)
        let eventEndDate = Date(timeIntervalSince1970: event.date_finish!.timeIntervalSince1970)
        let startOfDay = Calendar.current.startOfDay(for: eventEndDate)
        return eventEndDate.timeIntervalSince1970 - startOfDay.timeIntervalSince1970
    }

    deinit {
           NotificationCenter.default.removeObserver(self)
       }
}
