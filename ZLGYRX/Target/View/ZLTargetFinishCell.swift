//
//  ZLTargetFinishCell.swift
//  ZLGYRX
//
//  Created by iOS软件工程师 on 2018/11/28.
//  Copyright © 2018 iOS软件工程师. All rights reserved.
//

import UIKit

class ZLTargetFinishCell: UITableViewCell {

    func setUpviews() {
        backgroundColor = UIColor.clear
        selectionStyle = .none
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
        BG.addSubview(targetLab)
        targetLab.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(17)
            make.width.equalTo(150)
            make.height.equalTo(25)
        }
        BG.addSubview(targetStateImg)
        targetStateImg.snp.makeConstraints { (make) in
            make.width.height.equalTo(78)
            make.centerY.equalToSuperview()
            make.right.equalTo(-7)
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    private lazy var targetLab : UILabel = {
        let lab = UILabel()
        lab.text = "减肥到50KG"
        lab.textColor = UIColor.black
        lab.textAlignment = .left
        lab.font = ICYFONT18
        return lab
    }()
    private lazy var targetStateImg : UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "xmb_icon_stamp01")
        return img
    }()
}
