//
//  ZLGoldNumView.swift
//  ZLGYRX
//
//  Created by iOS软件工程师 on 2018/11/30.
//  Copyright © 2018 iOS软件工程师. All rights reserved.
//

import UIKit

class ZLGoldNumView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 230.0/255.0, green: 159.0/255.0, blue: 93.0/255.0, alpha: 0.15)
        layer.cornerRadius = height/2.0
        layer.masksToBounds = true
        setUpViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpViews() {
        addSubview(number)
        addSubview(goldImg)
        addSubview(addBtn)
    }
    private lazy var goldImg : UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: height, height: height))
        lab.text = "币"
        lab.font = ICYFONT15
        lab.textAlignment = .center
        lab.layer.cornerRadius = height/2.0
        lab.layer.masksToBounds = true
        lab.backgroundColor = ICYHEXCOLOR("#FFCC3A")
        lab.textColor = UIColor.black
        return lab
    }()
    lazy var number : UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        lab.textAlignment = .center
        lab.font = ICYFONT15
        lab.text = "166"
        lab.textColor = ICYHEXCOLOR("#E6615D")
        return lab
    }()
    lazy var addBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: width-height, y: 0, width: height, height: height)
        btn.setImage(#imageLiteral(resourceName: "dbsx_icon_plus"), for: .normal)
        return btn
    }()
}
