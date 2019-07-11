//
//  BaseNavigationController.swift
//  XWMobileProject
//
//  Created by xuwen on 2019/7/10.
//  Copyright © 2019 xuwen. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.black
//        navigationBar.isTranslucent = false
//        navigationBar.barTintColor = UIColor.white  //导航栏底色
//        
//        navigationBar.backgroundColor = UIColor.white
//        navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 18),NSAttributedString.Key.foregroundColor:UIColor.black]
//        
//        navigationBar.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 88)
//        navigationBar.shadowImage = UIImage()      //消除导航栏下面的黑线
    }
    
    //MARK - 自定义导航栏返回按钮
    func leftBarButtonItem() -> UIBarButtonItem {
        let backbtn = UIButton (frame: CGRect (x: 0, y: 0, width: 30, height: 30))
        backbtn.setImage(UIImage (named: "nav_return"), for: .normal)
        backbtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        backbtn.addTarget(self, action:#selector(navigationBackButtonAction), for: .touchUpInside)
        let leftitem = UIBarButtonItem.init(customView: backbtn)
        return leftitem
    }
    
    // MARK: - 重写pushViewController方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = leftBarButtonItem()
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK: - 返回按钮方法
    @objc func navigationBackButtonAction() {
        _ = popViewController(animated: true)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
    
    deinit {
        print("\(self.self) deinit")
    }

}
