//
//  MZDaysCell.swift
//  MZCalendar
//
//  Created by Jerry.li on 2018/10/17.
//  Copyright © 2018年 51app. All rights reserved.
//

import UIKit

class MZDaysCell: UICollectionViewCell {
    
    lazy var daysLabel: UILabel = {
//        let margin: CGFloat = (itemWidth - 32)/2.0
//        let daysLabel = UILabel(frame: CGRect(x: margin, y: margin, width: 32, height: 32))
//        daysLabel.textAlignment = .center
//        daysLabel.font = UIFont.systemFont(ofSize: 14)
//        daysLabel.layer.cornerRadius = 32.0 / 2.0
//        daysLabel.layer.masksToBounds = true
//        daysLabel.layer.shouldRasterize = true
        let daysLabel = UILabel(frame: CGRect(x: 0, y: 0, width: itemWidth, height: 21))
        daysLabel.textAlignment = .center
        daysLabel.backgroundColor = UIColor.clear
        daysLabel.font = UIFont.systemFont(ofSize: 15)
        return daysLabel
    }()
    private lazy var tickImg : UIImageView = {
        let img = UIImageView(frame: CGRect(x: (itemWidth - 12)/2.0, y: 21, width: 12, height: 9))
        img.isHidden = true
        img.image = #imageLiteral(resourceName: "xmb_icon_calender_check01")
        return img
    }()
    
    //是否标记
    var isPointHidden: Bool = false {
        didSet {
            if isPointHidden {
                backgroundColor = UIColor.red
                tickImg.isHidden = false
//                self.daysLabel.layer.addSublayer(self.pointLayer)
            } else {
                backgroundColor = UIColor.clear
                tickImg.isHidden = true
//                pointLayer.removeFromSuperlayer()
            }
        }
    }
    
    //是否是当天
    var isSelectedItem: Bool = false {
        didSet {
            if isSelectedItem {
                self.daysLabel.text = "今"
                self.daysLabel.textColor = UIColor.appThemeColor()
            } else {
                daysLabel.backgroundColor = UIColor.clear
                daysLabel.textColor = ICYHEXCOLOR("#818A9E")
            }
        }
    }
    
    //是否禁用
    var isDisable: Bool = false {
        didSet {
            if isDisable {
                self.daysLabel.textColor = ICYHEXCOLOR("#E4E4E4")
            }
        }
    }
    
    //清除现有日期label上的所有样式
    func clearDaysLabelStyle() {
        daysLabel.text = ""
        daysLabel.backgroundColor = UIColor.white
        daysLabel.textColor = ICYHEXCOLOR("333333")
        pointLayer.removeFromSuperlayer()
    }
    
    private lazy var pointLayer: CALayer = {
        let point = CALayer()
        point.backgroundColor = ICYHEXCOLOR("ff6c13").cgColor
        var originX: CGFloat = (self.daysLabel.frame.width - 6) / 2.0
        point.frame = CGRect(x: originX, y: self.daysLabel.frame.height - 6, width: 6, height: 6)
        point.cornerRadius = point.bounds.width / 2
        point.masksToBounds = true
        return point
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.cornerRadius = 3
        addSubview(daysLabel)
        addSubview(tickImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
