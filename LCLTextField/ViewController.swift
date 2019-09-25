//
//  ViewController.swift
//  LCLTextField
//
//  Created by 云淡风轻 on 2019/9/11.
//  Copyright © 2019 云淡风轻. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "LCLTextField"
        
        addTextFieldFirst()
        addTextFieldSecond()
        addTextFieldThird()
        addTextFieldFour()
    }
    
    func addTextFieldFirst() {
        let width = UIScreen.main.bounds.width
        
        let textField = LCLTextField()
        textField.frame = CGRect(x: 40, y: 100, width: width - 80, height: 40);
        textField.textAlignment = .left
        self.view.addSubview(textField)
        
        // 光标颜色
        textField.tintColor = .green
        
        // 文本颜色
        textField.textColor = .green
        
        // 提示语颜色
        textField.placeholderColor = .blue
        textField.placeholder = "请输入"
        
        // 最大文字长度
        textField.maxLength = 10
        
        // 点击textField, 如果处理编辑状态, 隐藏键盘
        textField.isHiddenKeyboardIfEditing = true
        
        // 添加内边距 - 上左下右
        textField.textInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        
        // 全部边框
        textField.addBorderAll(color: .red, borderWidth: 2)
        
        // 全部圆角
        textField.addCornerAll(radius: 10)
    }
    
    func addTextFieldSecond() {
        let width = UIScreen.main.bounds.width
        
        let textField = LCLTextField()
        textField.frame = CGRect(x: 40, y: 160, width: width - 80, height: 40);
        textField.textAlignment = .center
        self.view.addSubview(textField)
        
        // 光标颜色
        textField.tintColor = .orange
        
        // 文本颜色
        textField.textColor = .orange
        
        // 提示语颜色
        textField.placeholderColor = .green
        textField.placeholder = "请输入"

        // 最大文字长度
        textField.maxLength = 10
        
        // 点击textField, 如果处理编辑状态, 隐藏键盘
        textField.isHiddenKeyboardIfEditing = true
        
        // 添加内边距 - 上左下右
        textField.textInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        
        // 添加4条不同颜色的边框
        textField.addBorderLeft(color: .red, borderWidth: 2)
        textField.addBorderRight(color: .orange, borderWidth: 2)
        textField.addBorderTop(color: .yellow, borderWidth: 2)
        textField.addBorderBottom(color: .green, borderWidth: 2)
    }
    
    func addTextFieldThird() {
        let width = UIScreen.main.bounds.width
        
        let textField = LCLTextField()
        textField.frame = CGRect(x: 40, y: 220, width: width - 80, height: 40);
        textField.backgroundColor = .cyan
        textField.textAlignment = .right
        self.view.addSubview(textField)
        
        // 光标颜色
        textField.tintColor = .white
        
        // 文本颜色
        textField.textColor = .white
        
        // 提示语颜色
        textField.placeholderColor = .lightGray
        textField.placeholder = "请输入"

        // 最大文字长度
        textField.maxLength = 10
        
        // 点击textField, 如果处理编辑状态, 隐藏键盘
        textField.isHiddenKeyboardIfEditing = true
        
        // 添加内边距 - 上左下右
        textField.textInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        
        // 圆角
        textField.AddCorner(isTopLeft: true, isTopRight: false, isBottomLeft: false, isBottomRight: true, radius: 20)
    }
    
    func addTextFieldFour() {
        let width = UIScreen.main.bounds.width
        
        let textField = LCLTextField()
        textField.frame = CGRect(x: 40, y: 280, width: width - 80, height: 40);
        textField.backgroundColor = .black
        textField.textAlignment = .center
        self.view.addSubview(textField)
        
        // 光标颜色
        textField.tintColor = .white
        
        // 文本颜色
        textField.textColor = .white
        
        // 提示语颜色
        textField.placeholderColor = .lightGray
        textField.placeholder = "请输入"
        
        // 最大文字长度
        textField.maxLength = 10
        
        // 点击textField, 如果处理编辑状态, 隐藏键盘
        textField.isHiddenKeyboardIfEditing = true
        
        // 设置代理
//        textField.delegate = self // 不要使用这种方式设置代理
        textField.delegates.append(self)
        
        // 点击Return键, 隐藏键盘
        textField.isHiddenKeyboardWhenReturn = true
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
