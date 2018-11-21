//
//  ZLRegisterController.swift
//  ZLGYRX
//
//  Created by iOS软件工程师 on 2018/11/21.
//  Copyright © 2018 iOS软件工程师. All rights reserved.
//

import UIKit

class ZLRegisterController: ZLBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(back))
    }
    @objc private func back() {
        let anmaiton = CATransition.init()
        anmaiton.duration = 0.25
        anmaiton.type = CATransitionType.moveIn
        anmaiton.subtype = CATransitionSubtype.fromLeft
        UIApplication.shared.keyWindow?.layer.add(anmaiton, forKey: "anmaiton")
        self.navigationController?.popViewController(animated: false)
    }
}
