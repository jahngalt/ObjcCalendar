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
        //view.backgroundColor = .yellow
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
        view.setTime(time: "\(indexPath.item)H")
        return view
    }

    func calendarViewLayout(_ layout: CalendarViewLayout, timespanForCellAt indexPath: IndexPath) -> NSRange {
        return self.calendarController.eventAtIndex(index: indexPath.item).timespan
    }
}
