//
//  ZLTabBarController.swift
//  zlgy
//
//  Created by iOS软件工程师 on 2018/11/20.
//  Copyright © 2018 wcz. All rights reserved.
//

import UIKit

class ZLTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        normalSetting()
        setupUI()
    }
    
    private func normalSetting() {
        let tabbar = UITabBarItem.appearance()
        let attrsNormal = [NSAttributedString.Key.font:ICYFONT10,
                           NSAttributedString.Key.foregroundColor:ICYHEXCOLOR("#8E8E93")]
        let attraSelect = [NSAttributedString.Key.font:ICYFONT10,
                           NSAttributedString.Key.foregroundColor:ICYHEXCOLOR("#DA6D66")]
        tabbar.setTitleTextAttributes(attrsNormal, for: .normal)
        tabbar.setTitleTextAttributes(attraSelect, for: .selected)
        //        delegate = self
    }
    private func setupUI() {
        let tabBarVCArray : [UIViewController] = [ZLToDoViewController(),ZLTomatoController(),ZLTargetViewController()]
        let tabBarTitleArray = [("待办事项","dbsx"),("种番茄","zfq"),("小目标","xmb")]
        for (index, vc) in tabBarVCArray.enumerated() {
            vc.tabBarItem.title = tabBarTitleArray[index].0
            vc.tabBarItem.image = UIImage(named: "tabbar_icon_\(tabBarTitleArray[index].1)_disable")
            let selectedImage = UIImage(named: "tabbar_icon_\(tabBarTitleArray[index].1)")
            vc.tabBarItem.selectedImage = selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            let nvc = ZLNavigationController(rootViewController: vc)
            addChild(nvc)
        }
    }
}

//extension ICYTabBarController : UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//
//    }
//}
