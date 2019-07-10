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
            let arrResponse = response as! Dictionary<String, Any>
            let arr = arrResponse["statuses"] as! Array<[String:Any]>
            print(arr)
            
        }) { (error) in
            print("================%@",error.debugDescription)
        }
        
        
//        HttpClient.getRequest(url: weibo_test_url, params: params, successHandler: { (value) in
//            print(value["statuses"] as! [AnyObject])
//            var models:[WeiboListModel] = []
//            
//            for model in value["statuses"] as! [AnyObject] {
//                let bannerModel = WeiboListModel()
//                //映射到 model中
//                let dataModel  = WeiboListModel.deserialize(from: model)
//                models.append(bannerModel)
//            }
//            
//            returnData!(models)
//        }) { (error) in
//            print(error)
//        }
    }
}


