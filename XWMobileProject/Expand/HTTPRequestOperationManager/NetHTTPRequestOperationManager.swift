//
//  NetHTTPRequestOperationManager.swift
//  WPAlamofireTool
//
//  Created by kale.zhou on 2018/12/26.
//  Copyright © 2018 kale.zhou. All rights reserved.
//

import UIKit
import Alamofire

/// 网络请求类
open class NetHTTPRequestOperationManager {
    
    
    open var httpConfig: NetCommonConfigProtocol
    
    //单例
    public static let `default`: NetHTTPRequestOperationManager = {
        return NetHTTPRequestOperationManager(config: ALCommonConfig())
    }()
    
     //init方法
    required public init(config: NetCommonConfigProtocol) {
        httpConfig = config
    }
    
    //================= 请求方法 返回值JSON=======POST / GET 封装========================
    
    /// GET 请求
    ///
    /// - Parameters:
    ///   - URLString: 请求URl
    ///   - params: 请求参数
    ///   - success: 成功的回调
    ///   - failture: 失败的回调
    open func GETDataJSON(URLString : String,
                           params : [String : Any]?,
                           success : @escaping (_ responseObject :Any?)->(),
                           failture : @escaping (_ error : NSError)->()) {
        
        self.requestDataToJSON(.post, URLString: URLString, params: params, success: success, failture: failture)
    }
    
    /// POST 请求
    ///
    /// - Parameters:
    ///   - URLString: 请求URl
    ///   - params: 请求参数
    ///   - success: 成功的回调
    ///   - failture: 失败的回调
    open func POSTDataJSON(URLString : String,
                            params : [String : Any]?,
                            success : @escaping (_ responseObject : Any?)->(),
                            failture : @escaping (_ error : NSError)->()) {
        
        requestDataToJSON(.post, URLString: URLString, params: params, success: success, failture: failture)
    }
   
    
    ///底层网络请求封装======= 请求方法 返回值JSON===
    /// - Parameters:
    ///   - type: 请求类型
    ///   - URLString: 链接
    ///   - params: 参数
    ///   - success: 成功的回调
    ///   - failture: 失败的回调
    open func requestDataToJSON(_ type : HTTPMethod,
                                 URLString : String,
                                 params : [String : Any]?,
                                 urlEncoding : ParameterEncoding = URLEncoding.default,//JSONEncoding.default.有默认值则参数不提示
                                 header dictHeader:[String : String]? = nil,
                                 success : @escaping (_ responseObject : Any?)->(),
                                 failture : @escaping (_ error : NSError)->()) {
        
        //1.获取类型
        //let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //2.支持自定义Http头信息（HTTP Headers） cookie 信息
        // 配置 HTTPHeader
        //let headers: HTTPHeaders = [:]
        
        //let headerConfig = self.httpConfig.getHeader(dictHeader: headers)
    
        //3.设置返回数据格式
        let contentConfig = self.httpConfig.getContentType(contentType: nil)
        
        //4.底层发送网络请求
        Alamofire.request(URLString, parameters: params, encoding: URLEncoding.default).validate(contentType: contentConfig).responseJSON { response in
//        Alamofire.request(URLString, method: method,parameters:params,encoding:urlEncoding,
//                          headers:headerConfig).validate(contentType: contentConfig).responseJSON { (response) in
        
            switch response.result {
            
            //成功的回调
            case.success:
                
                if let value = response.result.value as? [String : AnyObject] {
                   
                    let json = String(data: response.data!, encoding: String.Encoding.utf8)
                    let jsonStr = (json?.visualFormat())!
                  
                    print("=============Method:\(type) 请求===============\n URL: \(URLString)\n请求参数: \(String(describing: params))\n请求响应:\(jsonStr)")
                    
                    //映射到 model中
                   let dataModel  = NetHTTPResponseModel.deserialize(from: value)
                    success(dataModel)
                }
            
            //失败的回调
            case .failure(let error):
                
                failture(error as NSError)
            }
        }
        
    }
 
    ///网络请求方法 返回值String====================================
    
    open func requestDataToString(_ type : HTTPMethod = .post,
                                   URLString : String,
                                   params : [String : Any]?,
                                   success : @escaping (_ responseObject : String)->(),
                                   failture : @escaping (_ error : NSError)->()) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.底层发送网络请求
        Alamofire.request(URLString, method: method, parameters: params).responseString { (response) in
            
            switch response.result {
            
            //请求成功回调
            case.success:
                if let value = response.result.value{
                    success(value)
                }
                
            //请求失败回调
            case .failure(let error):
                failture(error as NSError)
            }
        }
    }
    
    /// POST上传文件最终通用方法
    ///
    /// - Parameters:
    ///   - urlString: 请求的url
    ///   - dictHeader: 请求头
    ///   - parameter: 传入参数
    ///   - multipartFormData: 文件传入处理
    ///   - encodingCompletion: 结果回调(以枚举返回)
    open func uploadBase(url urlString:String,
                         header dictHeader:[String : String]? = nil,
                         parameter:[String : Any]? = [String : Any](),
                         multipartFormData: @escaping ((MultipartFormData)->Void),
                         encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?)
    {
        
        //Header的处理
        let header = self.httpConfig.getHeader(dictHeader: dictHeader)
        
        Alamofire.upload(multipartFormData: { (formData) in
            
            for (key, value) in parameter! {
                let v = String(describing: value)
                formData.append(v.data(using: .utf8)!, withName: key)
            }
            
            multipartFormData(formData)
        }, to: urlString, method: .post, headers: header, encodingCompletion: encodingCompletion)
    }
}



