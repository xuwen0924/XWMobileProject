//
//  NetHTTPResponseModel.swift
//  WPAlamofireTool
//
//  Created by kale.zhou on 2018/12/28.
//  Copyright © 2018 kale.zhou. All rights reserved.
//

import UIKit


class NetHTTPResponseModel: NetBaseModel {
    
    
    var r: Int?
    var d: Any?
    var m: String?
    
    var code: String?
    var info: String?
    var data: Any?

    required public init() { }
}
