//
//  ZLPunchCardController.swift
//  ZLGYRX
//
//  Created by iOS软件工程师 on 2018/11/28.
//  Copyright © 2018 iOS软件工程师. All rights reserved.
//

import UIKit

class ZLPunchCardController: ZLBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViews()
    }
    func setUpViews()  {
        UIView.gradualChange(view,colors: [ICYHEXCOLOR("#D96966"),ICYHEXCOLOR("#E8A669")])
        view.addSubview(dateLab)
        dateLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(17)
            make.top.equalTo(37)
        }
        view.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(33)
            make.top.equalTo(dateLab.snp.bottom).offset(27)
        }
        view.addSubview(punchCardView)
    }
    private lazy var dateLab : UILabel = {
        let lab = UILabel()
        lab.text = "20181010 - 20181111"
        lab.textAlignment = .center
        lab.font = ICYFONT12
        lab.textColor = ICYHEXCOLOR("#FFFFFF")
        return lab
    }()
    private lazy var titleLab : UILabel = {
        let lab = UILabel()
        lab.text = "减肥到50KG"
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 24)
        lab.textColor = ICYHEXCOLOR("#FFFFFF")
        return lab
    }()
    private lazy var punchCardView : ZLPunchCardView = {
        let view = ZLPunchCardView(frame: CGRect(x: 0, y: 0, width: 330, height: 417))
        view.center = CGPoint(x: kScreenWidth/2.0, y: kScreenHeight/2.0)
        return view
    }()
}
