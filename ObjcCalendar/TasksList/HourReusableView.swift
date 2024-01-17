//
//  HourReusableView.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//

import UIKit

let HourReusableViewTimeLineTopPadding: CGFloat = 6.0

class HourReusableView: UICollectionReusableView {
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()

    private let timeLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(timeLabel)
        addSubview(timeLineView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        timeLabel.frame = CGRect(x: 2, y: 0, width: 24, height: bounds.size.height)
        let timeLineFrame = CGRect(x: timeLabel.frame.maxX + 5, y: HourReusableViewTimeLineTopPadding, width: bounds.size.width - timeLabel.frame.maxX - 10, height: 0.5)
        timeLineView.frame = timeLineFrame
    }

    func setTime(time: String) {
        timeLabel.text = time
        timeLabel.sizeToFit()
        setNeedsLayout()
    }
}
