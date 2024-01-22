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
        label.textAlignment = .left
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

        let timeLabelWidth: CGFloat = 30
        let timeLabelX: CGFloat = 2

        let timeLineX = timeLabelX + timeLabelWidth + 5

        let timeLineY = bounds.size.height / 2 - 0.25
        let timeLineWidth = bounds.size.width - timeLineX - 10
        let timeLineHeight: CGFloat = 0.5

        timeLabel.frame = CGRect(x: timeLabelX, y: 0, width: timeLabelWidth, height: bounds.size.height)
        timeLineView.frame = CGRect(x: timeLineX, y: timeLineY, width: timeLineWidth, height: timeLineHeight)
        timeLineView.backgroundColor = .purple
    }

    func setTime(time: String) {
        timeLabel.text = time
        timeLabel.sizeToFit()
        setNeedsLayout()
    }
}
