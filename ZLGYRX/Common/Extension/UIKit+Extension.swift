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
