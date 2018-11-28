//
//  ZLSegmentBtn.swift
//  zlgy
//
//  Created by iOS软件工程师 on 2018/11/26.
//  Copyright © 2018 wcz. All rights reserved.
//

import UIKit

class ZLSegmentBtn: UIView {

    lazy var btn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: width, height: height-2)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = ICYFONT16
        btn.setTitleColor(UIColor.white, for: .normal)
        return btn
    }()
    lazy var line : UIView = {
        let line = UIView.init(frame: CGRect(x: 0, y: height-2, width: width, height: 2))
        line.backgroundColor = UIColor.white
        return line
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(btn)
        addSubview(line)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var title : String {
        set{
            btn.setTitle(newValue, for: .normal)
        }
        get{
            return ""
        }
    }
    
}
