//
//  UIView+Extension.swift
//  DSMobileProject
//
//  Created by kale.zhou on 2019/1/14.
//  Copyright © 2019 dashang. All rights reserved.
//

import UIKit

extension UIView {
    
    /// x
    public var _x: CGFloat {
        get { return frame.origin.x }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    public var _y: CGFloat {
        get { return frame.origin.y }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    public var _height: CGFloat {
        get { return frame.size.height }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    public var _width: CGFloat {
        get { return frame.size.width }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width  = newValue
            frame = tempFrame
        }
    }
    
    /// size
    public var _size: CGSize {
        get { return frame.size }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size        = newValue
            frame                 = tempFrame
        }
    }
    
    /// centerX
    public var _centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x            = newValue
            center                  = tempCenter
        }
    }
    
    /// centerY
    public var _centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y            = newValue
            center                  = tempCenter;
        }
    }
    
    /// bottom
    public var _bottom: CGFloat {
        get { return _y + _height }
        set(newVal) {
            _y = newVal - _height
        }
    }
    
//    /// 分割图
//    public static func segmentView(color: UIColor = .hexColor("#FFFFFF")) -> UIView {
//        let tempView = UIView()
//        tempView.backgroundColor = color
//        return tempView
//    }
    
    /// 移除所有的子视图
    public func clearAllSubViews() {
        if self.subviews.count > 0 {
            self.subviews.forEach { (subV) in
                subV.removeFromSuperview()
            }
        }
    }
    
    /** 部分圆角
     * @prama:
     * corners: 需要实现为圆角的角，可传入多个
     * radii: 圆角半径
     * 例子：
     * topLeft: [.topLeft]
     * topRight: [.topRight]
     * bottomLeft [.bottomLeft]
     * bottomRight: [.bottomRight]
     * top: [.topRight , .topLeft]
     * bottom: [.bottomRight , .bottomLeft]
     * left: [.topLeft , .bottomLeft]
     * right：[.topRight , .bottomRight]
     * all: [.topRight , .bottomRight , .topLeft , .bottomLeft]
     **/
    public func _corner(rectCorners corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }

    
    //适用于XIB中直接操作UIView
    /// 圆角
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    //描边宽度
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue > 0 ? newValue : 0
        }
    }
    
    //描边颜色
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
