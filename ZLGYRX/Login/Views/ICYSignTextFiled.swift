//
//  ICYSignTextFiled.swift
//  ZLGYRX
//
//  Created by iOS软件工程师 on 2018/11/20.
//  Copyright © 2018 iOS软件工程师. All rights reserved.
//

import UIKit

enum ICYSignTextFiledType {
    case none
    case clear
    case visible
}

class ICYSignTextFiled: UIView {

    var editType: ICYSignTextFiledType {
        didSet {
            switch editType {
            case .none:
                editBtn.setImage(nil, for: .normal)
            case .clear:
                editBtn.setImage(#imageLiteral(resourceName: "login_icon_forget"), for: .normal)
            case .visible:
                editBtn.setImage(#imageLiteral(resourceName: "login_icon_forget"), for: .normal)
                editBtn.setImage(#imageLiteral(resourceName: "login_icon_forget"), for: .selected)
            }
        }
    }
    
    override init(frame: CGRect) {
        self.editType = .none
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        textFiled.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(60)
            make.height.equalTo(44)
            make.right.equalToSuperview().offset(-20)
        }
        leftIcon.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(22)
            make.right.equalTo(textFiled.snp.left).offset(-15)
            make.centerY.equalTo(textFiled.snp.centerY)
        }
        editBtn.snp.makeConstraints { make in
            make.centerY.equalTo(textFiled.snp.centerY)
            make.width.height.equalTo(19)
            make.right.equalTo(-59)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(textFiled.snp.bottom)
            make.left.equalTo(29)
            make.right.equalTo(-37)
            make.height.equalTo(1)
        }
        
//        editBtn.rx.tap
//            .subscribe(onNext: { [weak self] in
//                switch self?.editType {
//                case .clear?:
//                    self?.textFiled.text = nil
//                case .visible?:
//                    self?.editBtn.isSelected = !(self?.editBtn.isSelected)!
//                    self?.textFiled.isSecureTextEntry = (self?.editBtn.isSelected)!
//                default: break
//                }
//            }).disposed(by: disposeBag)
//
//        textFiled.rx.controlEvent([.editingChanged])
//            .subscribe { [weak self] _ in
//                self?.editBtn.isHidden = false
//                self?.textFiled.textColor = .white
//            }.disposed(by: disposeBag)
//
//        textFiled.rx.controlEvent([.editingDidEnd])
//            .subscribe { [weak self] _ in
//                self?.editBtn.isHidden = true
//            }.disposed(by: disposeBag)
    }
    lazy var leftIcon : UIImageView = {
        let img = UIImageView.init(frame: CGRect.zero)
        addSubview(img)
        return img
    }()
    lazy var textFiled: UITextField = {
        let tf = UITextField.init()
        tf.font = ICYFONT16
        tf.textColor = UIColor.black
        tf.attributedPlaceholder = NSAttributedString.init(string: "", attributes: [NSAttributedString.Key.foregroundColor:ICYHEXCOLOR("#D4D4DB")])
        tf.delegate = self
        addSubview(tf)
        return tf
    }()
    private lazy var lineView: UIView = {
        let lv = UIView.init()
        lv.backgroundColor = UIColor.appGreyLineColor()
        addSubview(lv)
        return lv
    }()
    private lazy var editBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.isSelected = true
        btn.isHidden = false
        addSubview(btn)
        return btn
    }()
}

extension ICYSignTextFiled: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let rag = textFiled.text?.toRange(range)
//        let newStr = textFiled.text?.replacingCharacters(in: rag!, with: string)
//        if let text = newStr,
//            text.count > 30 {
//            let index = text.index(text.startIndex, offsetBy: 30)
//            textFiled.text = text.substring(to: index)
//            return false
//        }
        return true
    }
}
