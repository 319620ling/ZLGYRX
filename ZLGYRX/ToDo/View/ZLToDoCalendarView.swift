//
//  ZLToDoCalendarView
//  ZLToDoCalendarView
//
//  Created by Jerry.li on 2018/10/17.
//  Copyright © 2018年 51app. All rights reserved.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

class ZLToDoCalendarView: UIView {
    
    let itemWidth: CGFloat = 28.0
    
    fileprivate var date = Date()
    fileprivate var isCurrentMonth: Bool = false //是否当月
    fileprivate var currentMonthTotalDays: Int = 0 //当月的总天数
    fileprivate var firstDayIsWeekInMonth: Int = 0 //每月的一号对于的周几
    fileprivate var lastSelectedItemIndex: IndexPath? //获取最后一次选中的索引
    fileprivate let today: String = String(Date.day(Date()))  //当天几号
    fileprivate var margin: CGFloat = 0.0
    var dataSourceSubject = BehaviorRelay<[SectionModel<String,Int>]>(value: [])
    let disposeBag = DisposeBag()
    
    var isOpen : Bool = false {
        didSet {
            var numberArr : [Int] = [Int]()
            if isOpen {
                for _ in 1..<self.firstDayIsWeekInMonth {
                    numberArr.append(0)
                }
                for int in 1...self.currentMonthTotalDays {
                    numberArr.append(int)
                }
            } else {
                let todayIsWeekInMonth : Int = Date.todayIsWeekInMonth()
                for number in 1...todayIsWeekInMonth {
                    numberArr.append(Int(today)!-todayIsWeekInMonth+number)
                }
                for number in todayIsWeekInMonth..<7 {
                    let day : Int = Int(today)!-todayIsWeekInMonth+number+1
                    numberArr.append(day)
                }
            }
            dataSourceSubject.accept([SectionModel(model: "", items: numberArr)])
        }
    }
    //有标记的
    var originPointArray: Array<Int> = Array<Int>() {
        didSet {
            calendarCollectionView.reloadData()
        }
    }
    
    private lazy var weekView: UIView = {
        //        let originY: CGFloat = self.calendarHeadView.height - 13.0 - 15.0
        let weekView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 17))
        weekView.backgroundColor = UIColor.clear
        //week
        var weekArray = ["一", "二", "三", "四", "五", "六", "日"]
        var originX: CGFloat = 0.0
        for weekStr in weekArray {
            let week = UILabel()
            week.frame = CGRect(x: originX, y: 0, width: itemWidth, height: 21)
            week.text = weekStr
            week.textColor = UIColor.white
            week.font = UIFont.boldSystemFont(ofSize: 12)
            week.textAlignment = .center
            weekView.addSubview(week)
            originX = week.frame.maxX + margin
        }
        return weekView
    }()

    fileprivate lazy var calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize(width: itemWidth, height: 36)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = margin
        
        let vWidth: CGFloat = width
        let tempRect = CGRect(x: 0, y: self.weekView.bottom+9, width: vWidth, height: 36*5+8*5)
        let calendarCollectionView = UICollectionView(frame: tempRect, collectionViewLayout: layout)
        calendarCollectionView.isScrollEnabled = false
        calendarCollectionView.backgroundColor = UIColor.clear
        calendarCollectionView.register(ZLToDoCalendarCell.self, forCellWithReuseIdentifier: ZLToDoCalendarCell.description())
        return calendarCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        margin = (width-7*itemWidth)/6.0
        //init
        _initCalendarInfo()
        addSubview(weekView)
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
        let rxDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: {(dataSource, tableview, indexPath, int) -> ZLToDoCalendarCell in
            let cell = self.calendarCollectionView.dequeueReusableCell(withReuseIdentifier: ZLToDoCalendarCell.description(), for: indexPath) as! ZLToDoCalendarCell
            cell.clearDaysLabelStyle()
            
            let index = indexPath.row
            if self.isOpen {
                if index < self.firstDayIsWeekInMonth-1 {
                    cell.daysLabel.text = ""
                    return cell
                }
            }
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
                    self.calendarCollectionView.scrollToItem(at: indexPath, at: .top, animated: false)
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
            if int > self.currentMonthTotalDays || int < 1{
                cell.daysLabel.text = ""
            }
            return cell
        })
        var numberArr : [Int] = [Int]()
        let todayIsWeekInMonth : Int = Date.todayIsWeekInMonth()
        for number in 1...todayIsWeekInMonth {
            numberArr.append(Int(today)!-todayIsWeekInMonth+number)
        }
        for number in todayIsWeekInMonth..<7 {
            let day : Int = Int(today)!-todayIsWeekInMonth+number+1
            numberArr.append(day)
        }
        dataSourceSubject.accept([SectionModel(model: "", items: numberArr)])
        dataSourceSubject.bind(to: calendarCollectionView.rx.items(dataSource: rxDataSource)).disposed(by: disposeBag)
    }
}

