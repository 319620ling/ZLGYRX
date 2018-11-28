//
//  UIKit+Extension.swift
//  ZLGYRX
//
//  Created by iOS软件工程师 on 2018/11/20.
//  Copyright © 2018 iOS软件工程师. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

let ICYFONT8 = UIFont.systemFont(ofSize: 8.0)
let ICYFONT9 = UIFont.systemFont(ofSize: 9.0)
let ICYFONT10 = UIFont.systemFont(ofSize: 10.0)
let ICYFONT11 = UIFont.systemFont(ofSize: 11.0)
let ICYFONT12 = UIFont.systemFont(ofSize: 12.0)
let ICYFONT13 = UIFont.systemFont(ofSize: 13.0)
let ICYFONT14 = UIFont.systemFont(ofSize: 14.0)
let ICYFONT15 = UIFont.systemFont(ofSize: 15.0)
let ICYFONT16 = UIFont.systemFont(ofSize: 16.0)
let ICYFONT17 = UIFont.systemFont(ofSize: 17.0)
let ICYFONT18 = UIFont.systemFont(ofSize: 18.0)
let ICYFONT19 = UIFont.systemFont(ofSize: 19.0)
let ICYFONT20 = UIFont.systemFont(ofSize: 20.0)
let ICYFONT21 = UIFont.systemFont(ofSize: 21.0)
let ICYFONT22 = UIFont.systemFont(ofSize: 22.0)
let ICYFONT23 = UIFont.systemFont(ofSize: 23.0)
let ICYFONT26 = UIFont.systemFont(ofSize: 26.0)
let ICYFONT30 = UIFont.systemFont(ofSize: 30.0)

func ICYHEXCOLOR(_ hex : String) -> UIColor {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substring(from: 1)
    }
    if (cString.count != 6) {
        return UIColor.red
    }
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
    let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}



extension UIColor {
    //主色调
    static func appThemeColor() -> UIColor {
        return ICYHEXCOLOR("#E6615D")
    }
    static func appGreyLineColor() -> UIColor {
        return ICYHEXCOLOR("#C7C7CC")
    }
}

extension UIView {
    /// 渐变色
    static func gradualChange (_ addView: UIView,colors: [CGColor]) {
        let gl = CAGradientLayer.init()
        gl.frame = addView.frame
        //        gl.startPoint = CGPoint(x: 0.5, y: 0)
        //        gl.endPoint = CGPoint(x: 0.5, y: 1)
        gl.colors = colors
        gl.locations = [0, 1.0];
        addView.layer.addSublayer(gl)
    }
    var x: CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            self.frame.origin.x = newValue
        }
    }
    var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            self.frame.origin.y = newValue
        }
    }
    var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            self.frame.size.width = newValue
        }
    }
    var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            self.frame.size.height = newValue
        }
    }
    var top: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            self.frame.origin.y = newValue
        }
    }
    var bottom: CGFloat{
        get{
            return self.frame.origin.y + self.frame.size.height
        }
        set{
            self.frame.origin.y = newValue - self.frame.size.height
        }
    }
    var left: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            self.frame.origin.x = newValue
        }
    }
    var right: CGFloat{
        get{
            return self.frame.origin.x + self.frame.size.width
        }
        set{
            self.frame.origin.x = newValue - self.frame.size.width
        }
    }
    var centerX: CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center.x = newValue
        }
    }
    var centerY: CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center.y = newValue
        }
    }
}

extension Date {
    /// Date转换String
    static func stringFromDate(date: Date, format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter.init()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = format
        let dateString = formatter.string(from: date)
        return dateString
    }
    /// 上个月
    static func lastMonth(_ date: Date) -> Date {
        var dateCom = DateComponents()
        dateCom.month = -1
        let newDate = (Calendar.current as NSCalendar).date(byAdding: dateCom, to: date, options: NSCalendar.Options.matchStrictly)
        return newDate!
    }
    /// 下个月
    static func nextMonth(_ date: Date) -> Date {
        var dateCom = DateComponents()
        let abc = 1
        dateCom.month = +abc
        let newDate = (Calendar.current as NSCalendar).date(byAdding: dateCom, to: date, options: NSCalendar.Options.matchStrictly)
        return newDate!
    }
    /// 当月的天数
    static func daysInCurrMonth(date: Date) -> Int {
        let days: NSRange = (Calendar.current as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date)
        return days.length
    }
    /// 当前月份的第一天是周几
    static func firstDayIsWeekInMonth(date: Date) -> Int {
        var calender = Calendar.current
        calender.firstWeekday = 1
        var com = (calender as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day], from: date)
        com.day = 1
        let firstDay = calender.date(from: com)
        let firstWeek = (calender as NSCalendar).ordinality(of: NSCalendar.Unit.weekday, in: NSCalendar.Unit.weekOfMonth, for: firstDay!)
        return firstWeek - 1
    }
    /// 当前月份的几号
    static func day(_ date: Date) -> Int {
        let com = (Calendar.current as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day], from: date)
        return com.day!
    }
}
