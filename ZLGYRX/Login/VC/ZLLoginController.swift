//
//  ZLLoginController.swift
//  ZLGYRX
//
//  Created by iOS软件工程师 on 2018/11/19.
//  Copyright © 2018 iOS软件工程师. All rights reserved.
//

import UIKit

class ZLLoginController: ZLBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        setUpViews()
    }
    fileprivate func setUpViews() {
        view.addSubview(topIcon)
        view.addSubview(lab)
        view.addSubview(lab1)
        view.addSubview(loginTF)
        view.addSubview(passWordTF)
        view.addSubview(loginBtn)
        view.addSubview(bottomIcon)
        view.addSubview(registerBtn)
        bottomIcon.addSubview(weiXinBtn)
        bottomIcon.addSubview(weiBoBtn)
        bottomIcon.addSubview(qqBtn)
    }
    fileprivate func bindToView() {
        let signInViewModel = SignInViewModel.init(input: (username: loginTF.textFiled.rx.text.orEmpty.asDriver(), password: loginTF.textFiled.rx.text.orEmpty.asDriver(), signInTaps: loginBtn.rx.tap.asObservable().share()))
        
        loginBtn.rx.tap.subscribe { event in
            print("123")
        }.disposed(by: disposeBag)
    }
    fileprivate lazy var topIcon : UIImageView = {
        let img = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 172, height: 220))
        img.image = #imageLiteral(resourceName: "login_bg_tomato")
        return img
    }()
    fileprivate lazy var lab : UILabel = {
        let lab = UILabel.init(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        lab.text = "登陆"
        lab.textColor = UIColor.appThemeColor();
        lab.textAlignment = .center
        lab.font = ICYFONT17
        return lab
    }()
    fileprivate lazy var lab1 : UILabel = {
        let lab = UILabel.init(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        lab.text = "准备关注"
        lab.textColor = UIColor.appThemeColor();
        lab.textAlignment = .center
        lab.alpha = 0.5;
        lab.font = ICYFONT15
        return lab
    }()
    fileprivate lazy var loginTF : ICYSignTextFiled = {
        let tf = ICYSignTextFiled.init(frame: CGRect(x: 0, y: topIcon.frame.maxY+60, width: kScreenWidth, height: 45))
        tf.editType = .clear
        tf.leftIcon.image = #imageLiteral(resourceName: "login_icon_phone")
        tf.textFiled.placeholder = "输入手机号"
        return tf;
    }()
    fileprivate lazy var passWordTF : ICYSignTextFiled = {
        let tf = ICYSignTextFiled.init(frame: CGRect(x: 0, y: loginTF.frame.maxY+10, width: kScreenWidth, height: 45))
        tf.editType = .clear
        tf.leftIcon.image = #imageLiteral(resourceName: "login_icon_pw")
        tf.textFiled.placeholder = "输入密码"
        return tf;
    }()
    fileprivate lazy var loginBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: (kScreenWidth-220)/2.0, y: passWordTF.frame.maxY+30, width: 220, height: 40)
        btn.setTitle("登 录", for: .normal)
        btn.titleLabel?.font = ICYFONT16
        btn.setTitleColor(ICYHEXCOLOR("0xFFFFFF"), for: .normal)
        btn.alpha = 0.5
//        btn.isEnabled = false
        btn.backgroundColor = UIColor.appThemeColor()
        btn.layer.cornerRadius = 20
        return btn;
    }()
    lazy var registerBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: (kScreenWidth-70)/2.0, y: loginBtn.frame.maxY+36, width: 70, height: 20)
        btn.setTitle("立即注册", for: .normal)
        btn.titleLabel?.font = ICYFONT14
        btn.setTitleColor(UIColor.appThemeColor(), for: .normal)
        btn.backgroundColor = UIColor.clear
        return btn;
    }()
    fileprivate lazy var bottomIcon : UIImageView = {
        let img = UIImageView.init(frame: CGRect(x: 0, y: kScreenHeight-104, width: kScreenWidth, height: 104))
        img.image = #imageLiteral(resourceName: "login_bg_down")
        img.isUserInteractionEnabled = true
        return img
    }()
    private lazy var weiXinBtn : UIButton = {
        var btn = createThirdLoginBtn(name: "微信登陆", iconName: "login_icon_sns_weixin")
        btn.frame = CGRect(x: (kScreenWidth-3*46)/4.0, y: (bottomIcon.frame.height-60)/2.0, width: 46, height: 60)
        return btn;
    }()
    private lazy var weiBoBtn : UIButton = {
        var btn = createThirdLoginBtn(name: "微博登陆", iconName: "login_icon_sns_weibo")
        btn.frame = CGRect(x: (kScreenWidth-3*46)/4.0*2+46, y: (bottomIcon.frame.height-60)/2.0, width: 46, height: 60)
        return btn;
    }()
    private lazy var qqBtn : UIButton = {
        var btn = createThirdLoginBtn(name: "QQ登陆", iconName: "login_icon_sns_qq")
        btn.frame = CGRect(x: (kScreenWidth-3*46)/4.0*3+46*2, y: (bottomIcon.frame.height-60)/2.0, width: 46, height: 60)
        return btn;
    }()
    private func createThirdLoginBtn(name: String,iconName: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setTitle(name, for: .normal)
        btn.titleLabel?.font = ICYFONT10
        btn.setTitleColor(ICYHEXCOLOR("0xFFFFFF"), for: .normal)
        btn.setImage(UIImage.init(named: iconName), for: .normal)
        return btn;
    }
}
