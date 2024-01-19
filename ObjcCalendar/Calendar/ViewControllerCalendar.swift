//
//  ViewController.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//

import UIKit

protocol CalendarDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}

class ViewControllerCalendar: UIViewController {
    
    var calendarController: CalendarController!
    
    func calendarViewLayout(_ layout: CalendarViewLayout, timespanForCellAt indexPath: IndexPath) -> NSRange {
        return NSRange(location: indexPath.item * 60, length: 60)
    }
    
    weak var delegate: CalendarDelegate?
    
    var tasks: [TaskModel] = TaskManager().getTasks()
    
    var filteredTasks: [TaskModel] = []
    
    var selectedIndexPath: IndexPath?
    
    var selectedDay: Int = 0
    var firstDayIndex: Int?
    
    let calendarView = CalendarViewController()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var selectedDate = Date()
    var totalSquares = [String]()
    let calendarLayout = CalendarViewLayout()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        calendarController = CalendarController()
        setCellsView()
        setMonthView()

    }
    
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
       
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    

    func setMonthView() {
        totalSquares.removeAll()
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)

        

        for day in 1...42 {
            if day <= startingSpaces || day - startingSpaces > daysInMonth {
                totalSquares.append("")
            } else {
                let dayNumber = day - startingSpaces
                totalSquares.append(String(dayNumber))
                if dayNumber == 1 {
                    firstDayIndex = day - 1
                }
            }
        }
        
        if let firstDayIndex = firstDayIndex {
            selectedIndexPath = IndexPath(item: firstDayIndex, section: 0)
        } else {
            selectedIndexPath = nil
        }
     
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }

    
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
        //print("Count: ", totalSquares.count)
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
}

extension ViewControllerCalendar: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return totalSquares.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CalendarCell
        let day = totalSquares[indexPath.item]
        cell.dayOfMonth.text = day
        cell.layer.sublayers?.filter { $0 is CAShapeLayer }.forEach { $0.removeFromSuperlayer() }
        
        
        if let selectedIndexPath = selectedIndexPath, selectedIndexPath == indexPath {
            let circleLayer = CAShapeLayer()
            let circularPath = UIBezierPath(arcCenter: CGPoint(x: cell.frame.width / 2, y: cell.frame.height / 2), radius: cell.frame.width / 2 - 5, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
            circleLayer.path = circularPath.cgPath
                    circleLayer.fillColor = UIColor.clear.cgColor
                    circleLayer.strokeColor = UIColor.red.cgColor
                    circleLayer.lineWidth = 2
                    cell.layer.addSublayer(circleLayer)
            cell.layer.cornerRadius = cell.frame.width / 2
            } else {
                cell.backgroundColor = day.isEmpty ? UIColor.clear : UIColor.white
                cell.layer.cornerRadius = 0
            }
        return cell
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if totalSquares[indexPath.item].isEmpty {
            // Не обрабатываем выбор пустых ячеек
            return
        }
        
        let day = totalSquares[indexPath.item]
        guard !day.isEmpty else {
                    collectionView.deselectItem(at: indexPath, animated: false)
                    return
                }
        
        
        selectedIndexPath = indexPath
        
        // Получите выбранную дату
        guard let selectedDate = getDateFromSelectedCell(at: indexPath) else { return  }
        print("selected date: \(selectedDate)")
        userDidSelectDate(selectedDate)
            
        selectedIndexPath = indexPath

        collectionView.reloadData()
    }
    

    
    func getDateFromSelectedCell(at indexPath: IndexPath) -> Date? {
        guard indexPath.item < totalSquares.count else { return nil }

        let calendar = Calendar.current
        let year = calendar.component(.year, from: selectedDate)
        let month = calendar.component(.month, from: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)

        let dayIndex = indexPath.item - startingSpaces + 2 // Исправлено: учет смещения

        guard dayIndex > 0 else { return nil } // Проверка на валидность дня

        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = dayIndex

        guard let date = calendar.date(from: dateComponents) else { return nil }

        // Сбрасываем время до начала дня
        return calendar.startOfDay(for: date)
    }

    
    func userDidSelectDate(_ selectedDate: Date) {
           delegate?.didSelectDate(selectedDate)
       }
}

