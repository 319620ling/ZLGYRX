//
//  ZLTargetTableViewCell.swift
//  ZLGYRX
//
//  Created by iOS软件工程师 on 2018/11/27.
//  Copyright © 2018 iOS软件工程师. All rights reserved.
//

import UIKit

class ZLTargetTableViewCell: UITableViewCell {

    func setUpviews() {
        backgroundColor = UIColor.clear
        let BG = UIView()
        BG.backgroundColor = UIColor.white
        addSubview(BG)
        BG.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-25)
        }
        BG.layer.shadowOpacity = 0.2
        BG.layer.shadowColor = ICYHEXCOLOR("#A00000").cgColor
        BG.layer.shadowRadius = 5
        BG.layer.cornerRadius = 5
        BG.layer.shadowOffset = CGSize(width: 1, height: 5)
        BG.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(17)
            make.width.equalTo(150)
            make.height.equalTo(17)
        }
        BG.addSubview(subTitle)
        subTitle.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.equalTo(-17)
            make.width.equalTo(150)
            make.height.equalTo(17)
        }
        BG.addSubview(targetLab)
        targetLab.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(17)
            make.width.equalTo(150)
            make.height.equalTo(25)
        }
        BG.addSubview(residueTimeLab)
        residueTimeLab.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.right.equalTo(-17)
            make.width.equalTo(150)
            make.height.equalTo(25)
        }
        let bottomBG = UIView()
        bottomBG.backgroundColor = ICYHEXCOLOR("#FBE5E0")
        bottomBG.alpha = 0.6
        BG.addSubview(bottomBG)
        bottomBG.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(32)
        }
        BG.addSubview(punchCard)
        punchCard.snp.makeConstraints { (make) in
            make.centerX.equalTo((kScreenWidth-15*2)/4.0+15)
            make.width.equalTo(44)
            make.bottom.equalTo(-6)
            make.height.equalTo(20)
        }
        BG.addSubview(gotoSend)
        gotoSend.snp.makeConstraints { (make) in
            make.centerX.equalTo((kScreenWidth-15*2)/4.0*3+15)
            make.width.equalTo(70)
            make.bottom.equalTo(-6)
            make.height.equalTo(20)
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setUpviews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    private lazy var title : UILabel = {
        let lab = UILabel()
        lab.text = "20181201"
        lab.textColor = UIColor.appThemeColor()
        lab.textAlignment = .left
        lab.font = ICYFONT12
        return lab
    }()
    private lazy var subTitle : UILabel = {
        let lab = UILabel()
        lab.text = "距离目标还剩"
        lab.textColor = UIColor.appThemeColor()
        lab.textAlignment = .right
        lab.font = ICYFONT12
        return lab
    }()
    private lazy var targetLab : UILabel = {
        let lab = UILabel()
        lab.text = "减肥到50KG"
        lab.textColor = UIColor.black
        lab.textAlignment = .left
        lab.font = ICYFONT18
        return lab
    }()
    private lazy var residueTimeLab : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.black
        lab.textAlignment = .right
        let string  = "83天"
        let attrstring: NSMutableAttributedString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 36)])
        attrstring.setAttributes([NSAttributedString.Key.font : ICYFONT14], range: NSMakeRange(2,1))
        lab.attributedText = attrstring
        return lab
    }()
    lazy var punchCard : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("打卡", for: .normal)
        btn.setTitleColor(UIColor.appThemeColor(), for: .normal)
        btn.titleLabel?.font = ICYFONT14
        btn.setImage(#imageLiteral(resourceName: "xmb_icon_calender"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -32, bottom: 0, right: 0)
        return btn
    }()
    lazy var gotoSend : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("为它去种", for: .normal)
        btn.setTitleColor(UIColor.appThemeColor(), for: .normal)
        btn.titleLabel?.font = ICYFONT14
        btn.setImage(#imageLiteral(resourceName: "icon_disclosureindicator_red"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 47, bottom: 0, right: 0)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -47, bottom: 0, right: 0)
        return btn
    }()
}
