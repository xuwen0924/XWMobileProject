//
//  WeiboListModel.swift
//  MobileProject
//
//  Created by xuwen on 2017/3/21.
//  Copyright © 2017年 xuwen. All rights reserved.
//

import UIKit

class WeiboListModel: BaseModel {

    var id: String = ""
    var userId: String = ""
    var weiboId: String = ""
    var userName: String = ""
    var imageUrl: String = ""
    var date: String = ""
    var text: String = ""
    
    class func fetchPublicWeiBo(returnData: (([WeiboListModel]) -> Void)?) -> Void {
        
        let params: [String: String] = ["access_token": ACCESSTOKEN,
                                        "count": "100",
                                        ]
        
        NetHTTPRequestOperationManager.default.POSTDataJSON(URLString: weibo_test_url, params: params, success: { (response) in
            
            //1 确定返回数据的类型
            let arrResponse = response as! NetHTTPResponseModel
            let arr = arrResponse.statuses as! Array<[String:Any]>
            var modelList:[WeiboListModel] = []
            for item in arr {
                let model:WeiboListModel = WeiboListModel.deserialize(from: item) ?? WeiboListModel()
                modelList.append(model)
            }
            returnData!(modelList)
        }) { (error) in
            print(error.debugDescription)
        }
    }
}


