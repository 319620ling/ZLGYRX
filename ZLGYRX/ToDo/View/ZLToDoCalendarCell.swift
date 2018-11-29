//
//  MZDaysCell.swift
//  MZCalendar
//
//  Created by Jerry.li on 2018/10/17.
//  Copyright © 2018年 51app. All rights reserved.
//

import UIKit

class ZLToDoCalendarCell: UICollectionViewCell {
    
    lazy var daysLabel: UILabel = {
        let margin: CGFloat = (itemWidth - 28)/2.0
        let daysLabel = UILabel(frame: CGRect(x: margin, y: 0, width: 28, height: 28))
        daysLabel.backgroundColor = UIColor.clear
        daysLabel.textColor = ICYHEXCOLOR("#FFFFFF")
        daysLabel.textAlignment = .center
        daysLabel.font = UIFont.systemFont(ofSize: 14)
        daysLabel.layer.cornerRadius = 28.0 / 2.0
        daysLabel.layer.masksToBounds = true
        daysLabel.layer.shouldRasterize = true
        return daysLabel
    }()
    
    //是否标记
    var isPointHidden: Bool = false {
        didSet {
            if isPointHidden {
                layer.addSublayer(self.pointLayer)
            } else {
                pointLayer.removeFromSuperlayer()
            }
        }
    }
    
    //是否是当天
    var isSelectedItem: Bool = false {
        didSet {
            if isSelectedItem {
                daysLabel.text = "今"
                daysLabel.textColor = UIColor.appThemeColor()
                daysLabel.backgroundColor = UIColor.white
            } else {
                daysLabel.backgroundColor = UIColor.clear
                daysLabel.textColor = ICYHEXCOLOR("#FFFFFF")
            }
        }
    }
    
    //是否禁用
    var isDisable: Bool = false {
        didSet {
            if isDisable {
//                daysLabel.textColor = ICYHEXCOLOR("#E4E4E4")
            }
        }
    }
    
    //清除现有日期label上的所有样式
    func clearDaysLabelStyle() {
        daysLabel.text = ""
        daysLabel.backgroundColor = UIColor.clear
        daysLabel.textColor = ICYHEXCOLOR("#FFFFFF")
        pointLayer.removeFromSuperlayer()
    }
    
    private lazy var pointLayer: CALayer = {
        let point = CALayer()
        point.backgroundColor = ICYHEXCOLOR("FFFFFF").cgColor
        var originX: CGFloat = (self.daysLabel.frame.width - 6) / 2.0
        point.frame = CGRect(x: originX, y: self.daysLabel.frame.height+2, width: 6, height: 6)
        point.cornerRadius = point.bounds.width / 2
        point.masksToBounds = true
        return point
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.cornerRadius = 3
        addSubview(daysLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
