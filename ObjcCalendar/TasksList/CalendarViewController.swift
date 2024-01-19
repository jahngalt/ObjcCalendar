import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CalendarViewLayoutDelegate {
    
    
    var events: [Event] = []
    
    
    
    func displayEvents(_ events: [Event]) {
        self.events = events
        self.calendarController.setEvents(events)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        }

    var calendarController: CalendarController!
    var collectionView: UICollectionView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
           super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
           self.calendarController = CalendarController()
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           self.calendarController = CalendarController()
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
        print(indexPath.item)
        return view
    }
    
    func calendarViewLayout(_ layout: CalendarViewLayout, startTimeForCellAt indexPath: IndexPath) -> TimeInterval {
        let event = self.calendarController.eventAtIndex(index: indexPath.item)
        let startTimeTimestamp = event.date_start // Timestamp начала события (в секундах)
        let startOfDay = Calendar.current.startOfDay(for: Date()) // Начало текущего дня
        let startTimeInSeconds = startTimeTimestamp - startOfDay.timeIntervalSince1970 // Разница с началом дня
        return startTimeInSeconds
    }

    func calendarViewLayout(_ layout: CalendarViewLayout, endTimeForCellAt indexPath: IndexPath) -> TimeInterval {
        let event = self.calendarController.eventAtIndex(index: indexPath.item)
        let endTimeTimestamp = event.date_finish // Timestamp окончания события (в секундах)
        let startOfDay = Calendar.current.startOfDay(for: Date()) // Начало текущего дня
        let endTimeInSeconds = endTimeTimestamp - startOfDay.timeIntervalSince1970 // Разница с началом дня
        return endTimeInSeconds
    }
}
