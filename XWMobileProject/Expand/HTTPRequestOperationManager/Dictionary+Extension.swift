//
//  Dictionary+Extension.swift
//  WPAlamofireTool
//
//  Created by kale.zhou on 2018/12/26.
//  Copyright © 2018 kale.zhou. All rights reserved.
//

import Foundation

extension Dictionary {
    
    
    /// json字符串 转 String字符串
    ///
    /// - Returns: 返回字符串
    func jsonStr() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .init(rawValue: 0)), data.count > 0 else { return "" }
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    
    /// jsonValue
    ///
    /// - Returns: 返回字符串
    func jsonValue() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted), data.count > 0 else { return "" }
        return String(data: data, encoding: .utf8) ?? ""
    }
}
