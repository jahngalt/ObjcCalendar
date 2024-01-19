//
//  EventViewCell.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//

import UIKit

class EventViewCell: UICollectionViewCell {
    var event: Event? {
        didSet {
            guard let event = event else { return }
            self.layer.borderColor = UIColor.randomColor().cgColor
            self.backgroundColor = UIColor.randomColor().withAlphaComponent(0.2)
            self.label.text = event.name
            self.leftBorderView.backgroundColor = UIColor.randomColor()
            self.label.textColor = UIColor.randomColor()
            self.setNeedsLayout()
        }
    }

    private let leftBorderView: UIView = {
        let view = UIView()
        
        return view
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
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
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.leftBorderView.frame = CGRect(x: 0, y: 0, width: 4, height: self.bounds.size.height)
        let labelSize = self.label.sizeThatFits(CGSize(width: self.bounds.size.width - 10.0, height: CGFloat.greatestFiniteMagnitude))
        self.label.frame = CGRect(x: 8, y: 8, width: labelSize.width, height: labelSize.height)
    }
}
