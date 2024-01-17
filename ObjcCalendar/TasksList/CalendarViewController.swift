import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CalendarViewLayoutDelegate {
    
    
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
        // Ваша логика для расчета startTime в секундах
        let secondsPerCell: TimeInterval = 3600 // Количество секунд в каждой ячейке (1 час = 3600 секунд)
        let startTimeInSeconds = secondsPerCell * TimeInterval(indexPath.item)
        return startTimeInSeconds
    }

    func calendarViewLayout(_ layout: CalendarViewLayout, endTimeForCellAt indexPath: IndexPath) -> TimeInterval {
        // Ваша логика для расчета endTime в секундах
        let secondsPerCell: TimeInterval = 3600 // Количество секунд в каждой ячейке (1 час = 3600 секунд)
        let endTimeInSeconds = secondsPerCell * TimeInterval(indexPath.item + 1) // endTime следующей ячейки
        return endTimeInSeconds
    }



   
}
