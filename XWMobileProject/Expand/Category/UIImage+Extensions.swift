//
//  UIImage+Extensions.swift
//  DSMobileProject
//
//  Created by kale.zhou on 2019/1/14.
//  Copyright © 2019 dashang. All rights reserved.
//
import UIKit

extension UIImage {
    /// Create Image from color --- 根据一个颜色创建一个UIImage
    ///
    /// - Parameter color: 颜色
    /// - Returns: UIImaged?
    static public func createImageFromColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        let theImage =  UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if theImage != nil {
            return theImage!
        }
        return nil
    }
}
