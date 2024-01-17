//
//  CalendarViewLayout.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//

import UIKit

let CalendarViewLayoutHourViewHeight: CGFloat = 60.0
let CalendarViewLayoutLeftPadding: CGFloat = 30.0
let CalendarViewLayoutRightPadding: CGFloat = 10.0
let CalendarViewLayoutTimeLinePadding: CGFloat = 6.0


//протокол делегата
protocol CalendarViewLayoutDelegate: AnyObject {
    func calendarViewLayout(_ layout: CalendarViewLayout, timespanForCellAt indexPath: IndexPath) -> NSRange
}


class CalendarViewLayout: UICollectionViewLayout {
    
    //создаем атрибуты
    private var cellAttributes = [UICollectionViewLayoutAttributes]()
    private var hourAttributes = [UICollectionViewLayoutAttributes]()

    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView?.bounds.size.width ?? 0, height: CalendarViewLayoutHourViewHeight * 24 + CalendarViewLayoutTimeLinePadding)
    }

    override func prepare() {
        self.cellAttributes.removeAll()
        self.hourAttributes.removeAll()

        guard let collectionView = self.collectionView,
              let calendarViewLayoutDelegate = collectionView.delegate as? CalendarViewLayoutDelegate else {
            return
        }

        // Compute every events layoutAttributes
        for i in 0..<collectionView.numberOfSections {
            for j in 0..<collectionView.numberOfItems(inSection: i) {
                let cellIndexPath = IndexPath(item: j, section: i)
                let timespan = calendarViewLayoutDelegate.calendarViewLayout(self, timespanForCellAt: cellIndexPath)
                print(timespan)
                let posY = CGFloat(timespan.location) / 60.0 + CalendarViewLayoutTimeLinePadding
                print(posY)
                let height = CGFloat(timespan.length) / 60.0
                print(height)

                let attributes = UICollectionViewLayoutAttributes(forCellWith: cellIndexPath)
                attributes.frame = CGRect(x: CalendarViewLayoutLeftPadding, y: posY, width: collectionView.bounds.size.width - CalendarViewLayoutLeftPadding - CalendarViewLayoutRightPadding, height: height)
                self.cellAttributes.append(attributes)
            }
        }

        // Compute every 'hour block' layoutAttributes
        for i in 0..<24 {
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: "hour", with: IndexPath(item: i, section: 0))
            attributes.frame = CGRect(x: 0, y: CGFloat(i) * CalendarViewLayoutHourViewHeight, width: collectionView.bounds.size.width, height: CalendarViewLayoutHourViewHeight + (i == 23 ? CalendarViewLayoutTimeLinePadding : 0))
            self.hourAttributes.append(attributes)
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var allAttributes = [UICollectionViewLayoutAttributes]()

        for attributes in self.cellAttributes + self.hourAttributes {
            if rect.intersects(attributes.frame) {
                allAttributes.append(attributes)
            }
        }

        return allAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cellAttributes.first { $0.indexPath == indexPath }
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.hourAttributes.first { $0.indexPath == indexPath }
    }
}