//
//  LCLTextField.swift
//  SwiftUIDemo
//
//  Created by 云淡风轻 on 2019/9/10.
//  Copyright © 2019 com.lcl. All rights reserved.
//

import UIKit

class LCLTextField: UITextField, UITextFieldDelegate {
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.maxLength = Int.max
        
        self.delegator = LCLTextFieldDelegator()
        self.delegator?.textField = self
        self.delegate = self.delegator
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 自定义属性
    private var delegator: LCLTextFieldDelegator?
    
    /// 最大文字长度, 默认不限制长度
    var maxLength: Int?
    
    /// 文本的的内边距, 也就是距离上左下右的边距
    var textInsets: UIEdgeInsets?
    
    /// 隐藏键盘, 当处理编辑状态时
    var isHiddenKeyboardIfEditing = true
    
    /**
     * 占位符颜色
     * 保证不管先设置占位符颜色, 还是先设置占位符文本, 都不会出现bug
     */
    var placeholderColor: UIColor? {
        didSet {
            if self.placeholder != nil {
                self.attributedPlaceholder = NSAttributedString.init(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : self.placeholderColor!])
            }
        }
    }
    
    /**
     * 占位符文本
     * 保证不管先设置占位符颜色, 还是先设置占位符文本, 都不会出现bug
     */
    override var placeholder: String? {
        didSet {
            if self.placeholderColor != nil {
                self.attributedPlaceholder = NSAttributedString.init(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : self.placeholderColor!])
            }
        }
    }
    
    // MARK: 圆角
    /// 添加圆角 - 全部四个角
    func addCornerAll(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    /// 添加圆角 - 可以指定哪个角
    func AddCorner(isTopLeft: Bool, isTopRight: Bool, isBottomLeft: Bool, isBottomRight: Bool, radius: CGFloat) {
        
        if !(isTopRight || isTopRight || isBottomLeft || isBottomRight) {
            return
        }
        
        var corner: UIRectCorner?
        
        if isTopLeft {
            if corner != nil {
                corner = UIRectCorner(rawValue: corner!.rawValue | UIRectCorner.topLeft.rawValue)
            } else {
                corner = UIRectCorner.topLeft
            }
        }
        
        if isTopRight {
            if corner != nil {
                corner = UIRectCorner(rawValue: corner!.rawValue | UIRectCorner.topRight.rawValue)
            } else {
                corner = UIRectCorner.topRight
            }
        }

        if isBottomLeft {
            if corner != nil {
                corner = UIRectCorner(rawValue: corner!.rawValue | UIRectCorner.bottomLeft.rawValue)
            } else {
                corner = UIRectCorner.bottomLeft
            }
        }

        if isBottomRight {
            if corner != nil {
                corner = UIRectCorner(rawValue: corner!.rawValue | UIRectCorner.bottomRight.rawValue)
            } else {
                corner = UIRectCorner.bottomRight
            }
        }
        
        let p = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corner!, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = p.cgPath
        mask.frame = self.bounds
        self.layer.mask = mask
    }

    // MARK: 边框
    /// 添加全部边框
    func addBorderAll(color: UIColor, borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
    
    //// 添加左边框
    func addBorderLeft(color: UIColor, borderWidth: CGFloat) {
        let layer = CALayer.init()
        layer.frame = CGRect(x: 0 - borderWidth, y: 0, width: borderWidth, height: self.frame.size.height)
        layer.backgroundColor = color.cgColor
        self.layer.addSublayer(layer)
    }
    
    /// 添加右边框
    func addBorderRight(color: UIColor, borderWidth: CGFloat) {
        let layer = CALayer.init()
        layer.frame = CGRect(x: self.frame.size.width, y: 0, width: borderWidth, height: self.frame.size.height)
        layer.backgroundColor = color.cgColor
        self.layer.addSublayer(layer)
    }
    
    /// 添加上边框
    func addBorderTop(color: UIColor, borderWidth: CGFloat) {
        let layer = CALayer.init()
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: borderWidth)
        layer.backgroundColor = color.cgColor
        self.layer.addSublayer(layer)
    }
    
    /// 添加下边框
    func addBorderBottom(color: UIColor, borderWidth: CGFloat) {
        let layer = CALayer.init()
        layer.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: borderWidth)
        layer.backgroundColor = color.cgColor
        self.layer.addSublayer(layer)
    }
    
    // MARK: - Override Function
    /**
     * 占位符位置和大小的重写
     * Parameter bounds: 改变之前的位置和大小
     * Returns: 改变之后的位置和大小
     */
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = bounds
        rect.origin.x += self.textInsets!.left
        rect.origin.y += self.textInsets!.top
        rect.size.width -= (self.textInsets!.left + self.textInsets!.right)
        rect.size.height -= (self.textInsets!.top + self.textInsets!.bottom)
        return super.textRect(forBounds: rect)
    }
    
    /**
     * 文本位置和大小的重写
     * Parameter bounds: 改变之前的位置和大小
     * Returns: 改变之后的位置和大小
     */
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = bounds
        rect.origin.x += self.textInsets!.left
        rect.origin.y += self.textInsets!.top
        rect.size.width -= (self.textInsets!.left + self.textInsets!.right)
        rect.size.height -= (self.textInsets!.top + self.textInsets!.bottom)
        return super.textRect(forBounds: rect)
    }
}

protocol LCLTextFieldDelegate : UITextFieldDelegate {
    
}

class LCLTextFieldDelegator: NSObject, LCLTextFieldDelegate {
    var textField: LCLTextField? {
        didSet {
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
            self.textField!.addGestureRecognizer(tap)
            
            self.textField!.addTarget(self, action: #selector(LCLTextFieldDelegator.textFieldDidChanged(sender:)), for: .editingChanged)
        }
    }
    
    // MARK: - Action
    /// 摸一下输入框
    @objc func tapAction() {
        if self.textField != nil {
            if self.textField!.isHiddenKeyboardIfEditing {
                if self.textField!.isEditing {
                    self.textField!.resignFirstResponder()
                } else {
                    self.textField!.becomeFirstResponder()
                }
            }
        }
    }
    
    /// 长度限制
    @objc func textFieldDidChanged(sender: UITextField) {
        if self.textField!.maxLength != nil {
            sender.text = String((sender.text?.prefix(self.textField!.maxLength!))!)
        }
    }
}
