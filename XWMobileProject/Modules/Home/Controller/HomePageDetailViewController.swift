//
//  HomePageDetailViewController.swift
//  XWMobileProject
//
//  Created by xuwen on 2019/7/10.
//  Copyright © 2019 xuwen. All rights reserved.
//

import UIKit

class HomePageDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "详情"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //设置导航栏透明
        navigationController?.navigationBar.setBackgroundImage(UIImage.createImageFromColor(color: .clear), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
