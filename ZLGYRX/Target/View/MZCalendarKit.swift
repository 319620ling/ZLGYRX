//
//  MZCalendarKit.swift
//  MZCalendar
//
//  Created by Jerry.li on 2018/10/17.
//  Copyright © 2018年 51app. All rights reserved.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

let paddingLeft: CGFloat = 28.0
let itemWidth: CGFloat = 26.0

class MZCalendarKit: UIView {
    
    fileprivate var date = Date()
    fileprivate var isCurrentMonth: Bool = false //是否当月
    fileprivate var currentMonthTotalDays: Int = 0 //当月的总天数
    fileprivate var firstDayIsWeekInMonth: Int = 0 //每月的一号对于的周几
    fileprivate var lastSelectedItemIndex: IndexPath? //获取最后一次选中的索引
    fileprivate let today: String = String(Date.day(Date()))  //当天几号
    fileprivate var margin: CGFloat = 0.0
    var dataSourceSubject = BehaviorRelay<[SectionModel<String,Int>]>(value: [])
    let disposeBag = DisposeBag()

    //有标记的
    var originPointArray: Array<Int> = Array<Int>() {
        didSet {
            calendarCollectionView.reloadData()
        }
    }
    
    //日历控件头部
    private lazy var calendarHeadView: UIView = {
        let calendarHeadView = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: 42))
        UIView.gradualChange(calendarHeadView, colors: [UIColor.appThemeColor(),ICYHEXCOLOR("#F89F6E")])
        return calendarHeadView
    }()
    
    //日历控件title
//    fileprivate lazy var dateLabel: UILabel = {
//        let labelWidth: CGFloat = 100.0
//        let originX: CGFloat = (kScreenWidth - labelWidth) / 2.0
//        let dateLabel = UILabel(frame: CGRect(x: originX, y: 5, width: labelWidth, height: 20))
//        dateLabel.textAlignment = .center
//        dateLabel.textColor = UIColor.white
//        dateLabel.font = UIFont.systemFont(ofSize: 18)
//        dateLabel.backgroundColor = UIColor.clear
//        return dateLabel
//    }()
    
    //上个月
//    fileprivate lazy var lastMonthButton: UIButton = {
//        let last = self.createButton(imageName: "last_month_normal", disabledImage: "last_month_enabled")
//        last.frame.origin.x = self.dateLabel.frame.minX - last.width - 5
//        last.addTarget(self, action: #selector(lastAction), for: .touchUpInside)
//        return last
//    }()
    
    //下个月
//    fileprivate lazy var nextMonthButton: UIButton = {
//        let next = self.createButton(imageName: "next_month_normal", disabledImage: "next_month_enabled")
//        next.frame.origin.x = self.dateLabel.width
//        next.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
//        return next
//    }()
    
    private lazy var weekView: UIView = {
//        let originY: CGFloat = self.calendarHeadView.height - 13.0 - 15.0
        let weekView = UIView(frame: CGRect(x: paddingLeft, y: 11, width: width-paddingLeft*2, height: 21))
        weekView.backgroundColor = UIColor.clear
        //week
        var weekArray = ["一", "二", "三", "四", "五", "六", "日"]
        var originX: CGFloat = 0.0
        for weekStr in weekArray {
            let week = UILabel()
            week.frame = CGRect(x: originX, y: 0, width: itemWidth, height: 21)
            week.text = weekStr
            week.textColor = UIColor.white
            week.font = UIFont.boldSystemFont(ofSize: 15)
            week.textAlignment = .center
            weekView.addSubview(week)
            originX = week.frame.maxX + margin
        }
        return weekView
    }()
    
//    private func createButton(imageName: String, disabledImage: String) -> UIButton {
//        let image: UIImage = UIImage.init(named: imageName)!
//        let button = UIButton(type: .custom)
//        let originY: CGFloat = self.dateLabel.centerY - image.size.height / 2
//        button.frame = CGRect(x: 0, y: originY, width: image.size.width, height: image.size.height)
//        button.setBackgroundImage(image, for: .normal)
//        button.setBackgroundImage(image, for: .highlighted)
//        button.setBackgroundImage(UIImage(named: disabledImage), for: .disabled)
//        return button
//    }
    
    fileprivate lazy var calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize(width: 26, height: 32)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        
        let vWidth: CGFloat = width - paddingLeft * 2
        let tempRect = CGRect(x: paddingLeft, y: self.calendarHeadView.bottom, width: vWidth, height: 32*6+margin*5)
        let calendarCollectionView = UICollectionView(frame: tempRect, collectionViewLayout: layout)
        calendarCollectionView.backgroundColor = UIColor.white
//        calendarCollectionView.dataSource = self
//        calendarCollectionView.delegate = self
        calendarCollectionView.register(MZDaysCell.self, forCellWithReuseIdentifier: MZDaysCell.description())
        return calendarCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        margin = (width-paddingLeft*2-7*itemWidth)/6.0
        //init
        _initCalendarInfo()
        
        self.addSubview(calendarHeadView)
//        calendarHeadView.addSubview(dateLabel)
//        calendarHeadView.addSubview(lastMonthButton)
//        calendarHeadView.addSubview(nextMonthButton)
        calendarHeadView.addSubview(weekView)
        self.addSubview(calendarCollectionView)
        bindToView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //初始化日历信息
    func _initCalendarInfo() {
        //当前月份的总天数
        self.currentMonthTotalDays = Date.daysInCurrMonth(date: date)
        //当前月份第一天是周几
        self.firstDayIsWeekInMonth = Date.firstDayIsWeekInMonth(date: date)
//        self.dateLabel.text = Date.stringFromDate(date: date, format: "yyyy-MM")
        //是否当月
        let nowDate: String = Date.stringFromDate(date: Date(), format: "yyyy-MM")
        self.isCurrentMonth = nowDate == Date.stringFromDate(date: date, format: "yyyy-MM")
        //重置日历高度
        let days = self.currentMonthTotalDays + self.firstDayIsWeekInMonth
        let rowCount: Int = (days / 7) + 1
        let kitHeight: CGFloat = 32 * CGFloat(rowCount) + CGFloat(rowCount) * margin
        calendarCollectionView.frame.size.height = kitHeight
    }
    func bindToView() {
        let rxDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: {(dataSource, tableview, indexPath, int) -> MZDaysCell in
            let cell = self.calendarCollectionView.dequeueReusableCell(withReuseIdentifier: MZDaysCell.description(), for: indexPath) as! MZDaysCell
            cell.clearDaysLabelStyle()
            
            let index = indexPath.row
            if index < self.firstDayIsWeekInMonth-1 {
                cell.daysLabel.text = ""
            } else {
                cell.daysLabel.text = String(int)
                
                if self.originPointArray.contains(int) {
                    cell.isPointHidden = true
                }
                
                if self.isCurrentMonth {
                    //当天
                    if cell.daysLabel.text == self.today {
                        cell.isSelectedItem = true
                        self.lastSelectedItemIndex = indexPath
                    } else {
                        cell.isSelectedItem = false
                    }
                    
                    //当月当天以前的日期置灰，不可点击
                    var itemValue : String = cell.daysLabel.text!
                    if itemValue == "今" {
                        itemValue = self.today
                    }
                    let currDay = Int(itemValue)
                    if currDay! < Int(self.today)! {
                        cell.isDisable = true
                    }
                } else {
                    //非当前自然月的1号默认选中
                    if cell.daysLabel.text == "1" {
                        cell.isSelectedItem = true
                        self.lastSelectedItemIndex = indexPath
                    } else {
                        cell.isSelectedItem = false
                    }
                }
            }
            return cell
        })
        var numberArr : [Int] = [Int]()
        for _ in 1..<self.firstDayIsWeekInMonth {
            numberArr.append(0)
        }
        for int in 1...self.currentMonthTotalDays {
            numberArr.append(int)
        }
        print(numberArr)
        dataSourceSubject.accept([SectionModel(model: "", items: numberArr)])
        dataSourceSubject.bind(to: calendarCollectionView.rx.items(dataSource: rxDataSource)).disposed(by: disposeBag)
    }
}

//extension MZCalendarKit: UICollectionViewDelegate, UICollectionViewDataSource {
    //UICollectionViewDataSource
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let days = self.currentMonthTotalDays + self.firstDayIsWeekInMonth
//        return days
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as! MZDaysCell
//        cell.clearDaysLabelStyle()
//
//        var day = 0
//        let index = indexPath.row
//
//        if index < self.firstDayIsWeekInMonth {
//            cell.daysLabel.text = ""
//        } else {
//            day = index - self.firstDayIsWeekInMonth + 1
//            cell.daysLabel.text = String(day)
//
//            if originPointArray.contains(day) {
//                cell.isPointHidden = true
//            }
//
//            if isCurrentMonth {
//                //当天
//                if cell.daysLabel.text == today {
//                    cell.isSelectedItem = true
//                    self.lastSelectedItemIndex = indexPath
//                } else {
//                    cell.isSelectedItem = false
//                }
//
//                //当月当天以前的日期置灰，不可点击
//                var itemValue : String = cell.daysLabel.text!
//                if itemValue == "今" {
//                    itemValue = today
//                }
//                let currDay = Int(itemValue)
//                if currDay! < Int(today)! {
//                    cell.isDisable = true
//                }
//            } else {
//                //非当前自然月的1号默认选中
//                if cell.daysLabel.text == "1" {
//                    cell.isSelectedItem = true
//                    self.lastSelectedItemIndex = indexPath
//                } else {
//                    cell.isSelectedItem = false
//                }
//            }
//        }
//        return cell
//    }
    
    //UICollectionViewDelegate
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let currentCell = collectionView.cellForItem(at: indexPath) as! MZDaysCell
//
//        //是否已经选中
//        guard !currentCell.isSelectedItem else {
//            return
//        }
//
//        //是否有值
//        let itemText: String = currentCell.daysLabel.text!
//        guard !itemText.isEmpty else {
//            return
//        }
//
//        let curDate = Date()
//        let today = Date.day(curDate)
//        let currDay = Int(itemText)
//
//        //选中日期小于当天并且非当月
//        if self.isCurrentMonth && currDay! < today {
//            return
//        }
//
//        //获取上一次选中的item
//        let preCell = collectionView.cellForItem(at: self.lastSelectedItemIndex!) as! MZDaysCell
//        preCell.isSelectedItem = false
//
//        //获取当前选中的item
//        currentCell.isSelectedItem = true
//        self.lastSelectedItemIndex = indexPath
//    }
//}

//extension MZCalendarKit {
//    @objc func lastAction() {
//        self.date = Date.lastMonth(date)
//        self._initCalendarInfo()
//        calendarCollectionView.reloadData()
//    }
//
//    @objc func nextAction() {
//        self.date = Date.nextMonth(date)
//        self._initCalendarInfo()
//        calendarCollectionView.reloadData()
//    }
//}
