//
//  ZLNavigationController.swift
//  ZLGYRX
//
//  Created by iOS软件工程师 on 2018/11/21.
//  Copyright © 2018 iOS软件工程师. All rights reserved.
//

import UIKit

class ZLNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationBar.tintColor = UIColor.appThemeColor()
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        viewController.navigationController?.navigationBar.isHidden = true
        super.pushViewController(viewController, animated: animated)
//        if self.viewControllers.count > 1 {
//            viewController.navigationController?.navigationBar.isHidden = false
//            //            viewController.navigationItem.leftBarButtonItem = RMNavigationController.backNavigationItem(target: self, action: #selector(back))
//        } else {
//            viewController.navigationController?.navigationBar.isHidden = true
//        }
    }
}
