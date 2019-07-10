//
//  String+Extension.swift
//  WPAlamofireTool
//
//  Created by kale.zhou on 2018/12/26.
//  Copyright © 2018 kale.zhou. All rights reserved.
//

import Foundation

// MARK: - String的类扩展，只能被String 对象使用

extension String {
    
    
    /// json 转字典
    ///
    /// - Returns: 返回字典
    func jsonStrToDict() -> [String : Any]? {
        guard let str = (self as NSString).removingPercentEncoding else { return nil }
        guard let data = str.data(using: String.Encoding.utf8) else { return nil }
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else { return nil }
        return dict
    }
}


extension String {
    
    /// 可视化格式（主要是：每个字段一行，{}单独一行）
    ///
    /// - Returns: 格式化后字符串
    func visualFormat() -> String {
        var str = self
        str = str.replacingOccurrences(of: "{", with: "{\n")
        str = str.replacingOccurrences(of: "}", with: "\n}")
        str = str.replacingOccurrences(of: "\":", with: "\" : ")
        str = str.replacingOccurrences(of: ",", with: ",\n")
        return str
    }
    
}

extension String {
    
    /// 本地化字符串
    public var localized: String {
        let res = NSLocalizedString(self, comment: "")
        return (res.count > 0) ? res : self
    }
    
    /// 每个中文首字母拼接
    public func firstChineseCharacters(lowercased: Bool) -> String {
        let ostr = NSMutableString.init(string: self)
        CFStringTransform(ostr as CFMutableString, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(ostr as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
        return ostr.capitalized.components(separatedBy: " ").map { (str) -> String in
            if str.count >= 1{
                let str_f = (str as NSString).substring(to: 1)
                return lowercased ? str_f.lowercased() : str_f.uppercased()
            }
            return ""
            }.joined(separator: "")
    }
    

    
    /// 是否包含中文
    public var isContainsChinese: Bool {
        for (_, value) in self.enumerated() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    /// 根据开始位置和长度截取字符串
    public func subString(start: Int, length: Int = -1) -> String? {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    
    ///判断系统选择的语言
    public static func getLanguageType() -> String {
        let def = UserDefaults.standard
        let allLanguages: [String] = def.object(forKey: "AppleLanguages") as! [String]
        let chooseLanguage = allLanguages.first
        return chooseLanguage ?? "en"
    }
    
    /** 将UTC时间转本地时间
     * @param
     * @self: 为服务器的时间：例如: "2018-12-31 12:31:00"
     * @serverDateFormat: 服务器的格式，需要对应，例如"yyyy-MM-dd HH:mm:ss"
     * @returnDateFormat: 返回的格式，根据自己想要的格式，例如："yyyy-MM-dd HH:mm:ss"
     */
    public func getUTCToLocal(_ serverDateFormat: String, returnDateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = serverDateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = returnDateFormat
        
        return dateFormatter.string(from: dt!)
    }
    
    
    /** 获取当前时间，指定为公历记法（区别佛历）
     * @param
     * @returnDateFormat: 返回的格式，根据自己想要的格式，例如："yyyy-MM-dd HH:mm:ss"
     */
    public static func getLocalTimeWith(_ returnDateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = returnDateFormat
        let locale = Locale.init(identifier: Locale.preferredLanguages[0])
        dateFormatter.locale = locale
        let locationStr = dateFormatter.string(from: Date())
        return locationStr
    }
    
    /** 货币形式输出
     * @param
     * @number: 保留位数,默认为2
     */
    public func getCurrencyFormatterWith(count: Int = 2) -> String {
        if self.isEmpty {
            return "0.00"
        }
        //保留位数
        let interceptValue = String(format: "%.\(count)f", (self as NSString).doubleValue)
        //添加分隔符
        let format = NumberFormatter()
        format.numberStyle = .decimal
        let formatValue = format.string(from: NSNumber(value: (interceptValue as NSString).doubleValue))
        return formatValue ?? ""
    }
    
}


