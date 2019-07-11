//
//  HomePageViewController.swift
//  MobileProject
//
//  Created by xuwen on 2017/3/20.
//  Copyright © 2017年 xuwen. All rights reserved.
//

import UIKit
import SnapKit

class HomePageViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    
    var tableView: UITableView!
    var dataArray: [WeiboListModel] = []
    
    var cellHeights = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "首页"
        
        //初始化视图
        initView();
        
        //请求数据
        requestData();
        
        let rightItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.camera, target: self, action: #selector(crashButtonTapped))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func crashButtonTapped(_ sender: AnyObject) {
        
    }

    
    func initView() -> Void {
        view.backgroundColor = UIColor.white
        tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    func requestData() -> Void {
        WeiboListModel.fetchPublicWeiBo { (dataArray) in
            print(dataArray)
            self.dataArray = dataArray
            self.cellHeights.append(self.kCloseCellHeight)
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        if indexPath.row < dataArray.count {
            let model: WeiboListModel = dataArray[indexPath.row]
            cell.textLabel?.text = model.text
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = HomePageDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
