//
//  ZLPunchCardView.swift
//  ZLGYRX
//
//  Created by iOS软件工程师 on 2018/11/28.
//  Copyright © 2018 iOS软件工程师. All rights reserved.
//

import UIKit

class ZLPunchCardView: UIView {

    func setUpViews()  {
        backgroundColor = ICYHEXCOLOR("#FFFFFF")
        alpha = 0.6
        layer.cornerRadius = 5
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        let topLeftDot = createDot()
        addSubview(topLeftDot)
        topLeftDot.snp.makeConstraints { (make) in
            make.width.height.equalTo(6)
            make.left.top.equalTo(4)
        }
        let topRightDot = createDot()
        addSubview(topRightDot)
        topRightDot.snp.makeConstraints { (make) in
            make.width.height.equalTo(6)
            make.top.equalTo(4)
            make.right.equalTo(-4)
        }
        let bottomLeftDot = createDot()
        addSubview(bottomLeftDot)
        bottomLeftDot.snp.makeConstraints { (make) in
            make.width.height.equalTo(6)
            make.left.equalTo(4)
            make.bottom.equalTo(-4)
        }
        let bottomRightDot = createDot()
        addSubview(bottomRightDot)
        bottomRightDot.snp.makeConstraints { (make) in
            make.width.height.equalTo(6)
            make.right.equalTo(-4)
            make.bottom.equalTo(-4)
        }
        addSubview(dateLab)
        dateLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(12)
            make.height.equalTo(25)
        }
        addSubview(punchCardBtn)
        punchCardBtn.layer.cornerRadius = 20
        punchCardBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(285)
            make.height.equalTo(40)
            make.bottom.equalTo(-30)
        }
        addSubview(calendarKit)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createDot() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: 6))
        view.layer.cornerRadius = 3
        view.backgroundColor = UIColor.appThemeColor()
        return view
    }
    private lazy var dateLab : UILabel = {
        let lab = UILabel()
        lab.text = "2018年10月"
        lab.textAlignment = .center
        lab.font = ICYFONT18
        lab.textColor = ICYHEXCOLOR("#D96966")
        return lab
    }()
    private lazy var punchCardBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("今日打卡", for: .normal)
        btn.setTitleColor(ICYHEXCOLOR("#FFFFFF"), for: .normal)
        btn.titleLabel?.font = ICYFONT16
        btn.backgroundColor = UIColor.appThemeColor()
        return btn
    }()
    private lazy var calendarKit: MZCalendarKit = {
        let calendarKit = MZCalendarKit(frame: CGRect(x: (width-285)/2.0, y: 37+15, width: 285, height: 266))
        calendarKit.originPointArray = [20, 23, 25]
        //        calendarKit.backgroundColor = UIColor.green
        return calendarKit
    }()
}
