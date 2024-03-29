//
//  EventViewCell.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//

import UIKit

class EventViewCell: UICollectionViewCell {
    var event: EventModel? {
        didSet {
            guard let event = event else { return }
            self.layer.borderColor = UIColor.randomColor().cgColor
            self.backgroundColor = UIColor.randomColor().withAlphaComponent(0.4)
            self.label.text = event.name
            self.desctiption.text = event.descriptionText
            self.leftBorderView.backgroundColor = UIColor.randomColor()
            self.label.textColor = UIColor.black
            self.setNeedsLayout()
        }
    }

    private let leftBorderView: UIView = {
        let view = UIView()

        return view
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let desctiption: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.addSubview(self.leftBorderView)
        self.addSubview(self.label)
        self.addSubview(self.desctiption)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.leftBorderView.frame = CGRect(x: 0, y: 0, width: 4, height: self.bounds.size.height)

        let labelX: CGFloat = 8
        let labelY: CGFloat = 8
        let labelWidth = self.bounds.size.width - labelX - 10.0
        let labelSize = self.label.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude))
        self.label.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelSize.height)
        let descriptionX = labelX
        let descriptionY = labelY + labelSize.height + 4
        let descriptionWidth = labelWidth
        let descriptionSize = self.desctiption.sizeThatFits(CGSize(width: descriptionWidth, height: CGFloat.greatestFiniteMagnitude))
        self.desctiption.frame = CGRect(x: descriptionX, y: descriptionY, width: descriptionWidth, height: descriptionSize.height)
    }
}
