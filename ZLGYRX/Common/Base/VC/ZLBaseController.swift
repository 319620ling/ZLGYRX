//
//  ZLBaseController.swift
//  ZLGYRX
//
//  Created by iOS软件工程师 on 2018/11/19.
//  Copyright © 2018 iOS软件工程师. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ZLBaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}
