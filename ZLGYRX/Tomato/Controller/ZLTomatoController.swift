//
//  ZLTomatoController.swift
//  ZLGYRX
//
//  Created by iOS软件工程师 on 2018/11/29.
//  Copyright © 2018 iOS软件工程师. All rights reserved.
//

import UIKit
import RxSwift

class ZLTomatoController: ZLBaseController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViews()
        bindToView()
        addGestureToView()
    }
    func setUpViews()  {
        view.addSubview(menuBtn)
        view.addSubview(goldNumView)
        view.addSubview(titleLab)
        view.addSubview(textF)
    }
    func bindToView()  {
        menuBtn.rx.tap.subscribe(onNext: {_ in
        }).disposed(by: disposeBag)
        goldNumView.addBtn.rx.tap.subscribe(onNext: {[weak self] _ in
            let num = Int(self!.goldNumView.number.text!)!+1
            self!.goldNumView.number.text = String(num)
        }).disposed(by: disposeBag)
        textF.rx.text.orEmpty.changed.subscribe(onNext: {[weak self] value in
            print(value)
        }).disposed(by:disposeBag)
        textF.rx.controlEvent(.editingDidEnd).subscribe(onNext: {[weak self] _ in
            self?.view.endEditing(true)
            print("点击了发送")
        }).disposed(by:disposeBag)
    }
    func addGestureToView() {
        let tapBackground = UITapGestureRecognizer()
        view.addGestureRecognizer(tapBackground)
        tapBackground.rx.event.subscribe(onNext: {[weak self] _ in
                self?.view.endEditing(true)
        }).disposed(by: disposeBag)
    }
    private lazy var menuBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 19, y: 42, width: 20, height: 15)
        btn.setImage(#imageLiteral(resourceName: "tabbar_icon_dbsx"), for: .normal)
        return btn
    }()
    private lazy var goldNumView : ZLGoldNumView = {
        let v = ZLGoldNumView(frame: CGRect(x: kScreenWidth-101-18, y: 39, width: 101, height: 28))
        return v
    }()
    private lazy var titleLab : UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: 88, width: kScreenWidth, height: 21))
        lab.textAlignment = .center
        lab.font = ICYFONT15
        lab.text = "做个有梦想的专注者"
        lab.textColor = ICYHEXCOLOR("#E0E0E4")
        return lab
    }()
    private lazy var textF : UITextField = {
        let tf = UITextField(frame: CGRect(x: (kScreenWidth-223)/2.0, y: titleLab.bottom+11, width: 223, height: 36))
        tf.layer.cornerRadius = 6
        tf.layer.shadowOpacity = 1
        tf.layer.shadowRadius = 6
        tf.layer.shadowColor = ICYHEXCOLOR("#CBCBCB").cgColor
        tf.layer.shadowOffset = CGSize(width: 1, height: 1)
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1
        tf.returnKeyType = .send

        let v = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 36))
        let img = UIImageView(frame: CGRect(x: 15, y: 10, width: 15, height: 15))
        img.image = #imageLiteral(resourceName: "zfq_icon_input")
        v.addSubview(img)
        tf.leftView = v
        tf.leftViewMode = .always
        return tf
    }()
}
