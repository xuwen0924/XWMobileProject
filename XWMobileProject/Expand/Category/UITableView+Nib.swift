//
//  UITableView+Nib.swift
//  DSMobileProject
//
//  Created by kale.zhou on 2019/1/14.
//  Copyright © 2019 dashang. All rights reserved.
//

import UIKit

protocol DSUIViewReusable {
    static var className: String { get }
}

extension DSUIViewReusable {
    static var className: String {
        return String(describing: self)
    }
}

extension UIView: DSUIViewReusable {}



extension UITableView {
    ///  注册 Cell, 名称作为 indentifier
    ///
    /// - Parameter cls: UIView
    public func registerCell<T: UIView>(cls: T.Type) {
        self.register(cls, forCellReuseIdentifier: T.className)
    }
    
    /// 用 xib 注册 Cell, 名称作为 indentifier
    ///
    /// - Parameter cls: UIView
    func registerCellFromNib<T: UIView>(cls: T.Type) {
        self.register(UINib(nibName: T.className, bundle: nil), forCellReuseIdentifier: T.className)
    }
    
    /// 用 xib 注册 Cell
    ///
    /// - Parameters:
    ///   - cls: UIView
    ///   - identifier: String
    func registerCellFromNib<T: UIView>(cls: T.Type, identifier: String) {
        self.register(UINib.init(nibName: T.className, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    /// 注册头和尾视图, 名称作为 indentifier
    ///
    /// - Parameter cls: UIView
    func registerHeaderFooter<T: UIView>(cls: T.Type) {
        self.register(cls, forHeaderFooterViewReuseIdentifier: T.className)
    }
    
    ///  用 xib 注册头和尾视图, 名称作为 indentifier
    ///
    /// - Parameter cls: UIView
    func registerHeaderFooterFromNib<T: UIView>(cls: T.Type) {
        self.register(UINib.init(nibName: T.className, bundle: nil), forHeaderFooterViewReuseIdentifier: T.className)
    }
    
    /// DequeueReuse cell --- 重用 cell
    ///
    /// - Parameters:
    ///   - cls: UIView
    ///   - indexPath: IndexPath
    /// - Returns: UIView
    func dequeueReuseCell<T: UIView>(_ cls: T.Type, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Can't dequeue reuseable cell with identifier = \(T.className)")
        }
        return cell
    }
    
    /// 注册Cell
    public func registerCellClass(_ cellClass: Swift.AnyClass) -> (){
        self.register(cellClass, forCellReuseIdentifier: NSStringFromClass(cellClass))
    }
    
    /// 注册HeaderFooter
    public func registerHeaderFooterClass<T:UITableViewHeaderFooterView>(_ clazz: T.Type) -> (){
        self.register(clazz, forHeaderFooterViewReuseIdentifier: NSStringFromClass(clazz))
    }
    
    /// Nib注册Cell
    public func registerCellNib(_ cellClass: Swift.AnyClass) -> (){
        let nib = UINib.init(nibName: NSStringFromClass(cellClass), bundle: nil)
        self.register(nib, forCellReuseIdentifier: NSStringFromClass(cellClass))
    }
    
    /// 拿缓存池的Cell
    public func deque<T:UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: NSStringFromClass(cellType), for: indexPath) as! T
    }
    
    /// 拿缓存池的HeaderFooter
    public func dequeHeaderFooter<T:UITableViewHeaderFooterView>(viewType: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(viewType)) as! T
    }
    
    ///  重用头和尾视图
    ///
    /// - Parameter cls: UIView
    /// - Returns: UIView
    func dequeueHeaderFooter<T: UIView>(_ cls: T.Type) -> T {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T else {
            fatalError("Can't dequeue reuseable HeaderFooterView with identifier = \(T.className)")
        }
        return view
    }
}

extension UIView {
    ///  从 xib 加载视图
    ///
    /// - Returns: UIView
    public class func loadNib() -> UIView {
        let nibName = String(describing: self)
        guard let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? UIView else {
            fatalError("Can't load nib with name = \(nibName)")
        }
        return view
    }
}
