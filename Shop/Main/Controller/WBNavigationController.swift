//
//  WBNavigationController.swift
//  微博
//
//  Created by 周璇 on 2016/11/10.
//  Copyright © 2016年 周璇. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if animated {
            let pop = self.viewControllers.last
            pop?.hidesBottomBarWhenPushed = false
        }
        return super.popToRootViewController(animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
        //隐藏默认的NavigationBar  容标题栏
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0),NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationBar.barTintColor = UIColor.white
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.black
        
        clearLine()
    }
    
    func imageFromColor(color: UIColor, viewSize: CGSize) -> UIImage{
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        
        context.fill(rect)
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsGetCurrentContext()
        return image!
    }
    
    func clearLine() {
        let list = navigationBar.subviews
        for objView in list {
            if #available(iOS 10.0, *) {
                if objView.isKind(of: NSClassFromString("_UIBarBackground")!) == true{
                    for subview in objView.subviews {
                        if subview.isKind(of: UIImageView.self) {
                            subview.isHidden = true
                        }
                    }
                }
            }else {
                if objView.isKind(of: NSClassFromString("_UINavigationBarBackground")!) == true{
                    for subview in objView.subviews {
                        if subview.isKind(of: UIImageView.self) {
                            subview.isHidden = true
                        }
                    }
                }
            }
//            if objView.isKind(of: NSClassFromString("_UINavigationBarBackIndicatorView")!) == true{
//                objView.isHidden = true
//            }
        }
    }
    //重写push 方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if children.count>0 {
            //隐藏底部的tabbar
            viewController.hidesBottomBarWhenPushed = true
            
            //判断控制器的类型
            if let vc = viewController as? BaseViewController {
                //判断控制器的级数
                
                //取出自定义的 navItem
                vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "goback"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
            }
        }
        self.interactivePopGestureRecognizer?.isEnabled = true
        super.pushViewController(viewController, animated: true)
        self.tabBarController?.tabBar.frame.origin.y = UIScreen.main.bounds.height - (self.tabBarController?.tabBar.frame.size.height)!
    }
    
    @objc private func goBack() {
        popViewController(animated: true)
    }
    
}
