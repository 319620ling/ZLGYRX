//
//  ZLToDoViewController.swift
//  ZLGYRX
//
//  Created by iOS软件工程师 on 2018/11/29.
//  Copyright © 2018 iOS软件工程师. All rights reserved.
//

import UIKit
import RxSwift

class ZLToDoViewController: ZLBaseController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViews()
        bindToView()
    }
    func setUpViews()  {
        view.addSubview(topBG)
        view.addSubview(dateLab)
        view.addSubview(calendarBtn)
        view.addSubview(contentBG)
        contentBG.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topBG.snp.bottom).offset(-21)
        }
        view.addSubview(calendarView)
    }
    func bindToView() {
        calendarBtn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else {return}
            self.topBG.layer.sublayers?.forEach({ (layer) in
                if layer.isKind(of: CAGradientLayer.self) {
                    layer.removeFromSuperlayer()
                }
            })
            self.calendarBtn.isSelected = !self.calendarBtn.isSelected
            self.calendarView.isOpen = self.calendarBtn.isSelected
            if self.calendarBtn.isSelected {
                self.topBG.height = 378
            } else {
                self.topBG.height = 177
            }
            UIView.gradualChange(self.topBG, colors: [ICYHEXCOLOR("#F89F6E"),UIColor.appThemeColor()])
        }).disposed(by: disposeBag)
    }
    private lazy var topBG : UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 177))
        UIView.gradualChange(v, colors: [ICYHEXCOLOR("#F89F6E"),UIColor.appThemeColor()])
        return v
    }()
    private lazy var contentBG : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 10
        return v
    }()
    private lazy var dateLab : UILabel = {
        let lab = UILabel(frame: CGRect(x: 40, y: 34, width: 96, height: 25))
        lab.text = "2018年10月"
        lab.textAlignment = .center
        lab.font = ICYFONT18
        lab.textColor = ICYHEXCOLOR("#FFFFFF")
        return lab
    }()
    lazy var calendarBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: kScreenWidth-20-38, y: 37, width: 20, height: 20)
        btn.setImage(#imageLiteral(resourceName: "dbsx_icon_calender"), for: .normal)
        return btn
    }()
    lazy var calendarView : ZLToDoCalendarView = {
//        let view = ZLToDoCalendarView(frame: CGRect(x: 40, y: 73, width: kScreenWidth-40*2, height: 70))
        let view = ZLToDoCalendarView(frame: CGRect(x: 40, y: 73, width: kScreenWidth-40*2, height: 209))
        view.originPointArray = [20, 23, 25]
        return view
    }()
}
