//
//  WBMainViewController.swift
//  微博
//
//  Created by 周璇 on 2016/11/10.
//  Copyright © 2016年 周璇. All rights reserved. 
//

import UIKit

//主控制器
class MainViewController: UITabBarController {
    
    var indexFlag = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
        setLayer()
        
    }
    
    func tabbarItemAnimationWithIndex(index: Int){
        var tabbarItem : [UIView] = []
        for tabBarButton in self.tabBar.subviews{
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!){
                tabbarItem.append(tabBarButton)
            }
        }
        
     }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let selectIndex = self.tabBar.items?.firstIndex(of: item)
        //声明的私有属性
        if self.indexFlag != selectIndex{
            self.tabbarItemAnimationWithIndex(index: selectIndex!)
        }
    }
    
}

extension MainViewController {
    fileprivate func setLayer() {
        let S_Width = UIScreen.main.bounds.size.width
        let bezier = UIBezierPath()
        bezier.move(to: CGPoint.zero)
        bezier.addLine(to: CGPoint(x: S_Width * 0.5 , y: 0))
        bezier.append(UIBezierPath(arcCenter: CGPoint(x: S_Width * 0.5, y: 15), radius: 0, startAngle: 0, endAngle: CGFloat.pi * -1, clockwise: false))
        bezier.move(to: CGPoint(x: S_Width * 0.5 , y: 0))
        bezier.addLine(to: CGPoint(x: S_Width, y: 0))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezier.cgPath
        shapeLayer.lineWidth = 0.5
        shapeLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1).cgColor
        tabBar.layer.insertSublayer(shapeLayer, at: 0)
        tabBar.backgroundImage = imageFromColor(color: UIColor.white, viewSize: tabBar.frame.size)
        self.delegate = self
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
}

// extension 类似于 OC 中的 分类，在 Swift 中还可以用来切分代码块
// 可以把相近功能的函数，放在一个 extension 中
// 便于代码维护
// 注意：和 OC 的分类一样，extension 中不能定义属性
// MARK: - 设置界面
extension MainViewController {
    
    // MARK: - private method
    /// 添加所有子控制器
    func addChildViewControllers() {
        setupOneChildViewController("首页", image: "icon-home-off", selectedImage: "icon-home-on", controller: HomeViewController(), index: 0)
        setupOneChildViewController("分类", image: "icon-zhungxiu-off", selectedImage: "icon-zhungxiu-on", controller: ViewController(), index: 1)
        setupOneChildViewController("附近商铺", image: "icon-huodong-off", selectedImage: "icon-huodong-on", controller: ViewController(), index: 2)
        setupOneChildViewController("个人中心", image: "icon-my-off", selectedImage: "icon-my-on", controller: ViewController(), index: 3)
    }
    
    /// 添加一个子控制器
    fileprivate func setupOneChildViewController(_ title: String, image: String, selectedImage: String, controller: UIViewController, index: Int, imgStrList: [String] = []) {
        controller.tabBarItem.title = title
        controller.title = title
        controller.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        
        let naviController = WBNavigationController.init(rootViewController: controller)
        addChild(naviController)
    }
}

extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }
    
    
}


extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage.init();
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
}

extension UIButton {
    
    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State, num: Int){
        self.imageView?.contentMode = .center
        self.setImage(anImage?.withRenderingMode(.alwaysOriginal), for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing, num: num)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode,
                                             spacing: CGFloat, num: Int) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        _ = self.frame.size.width
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            if num == 0 {
                imageInsets = UIEdgeInsets(top: -15, left: 0, bottom: 0, right: -titleSize.width)
                titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                           left: -(imageSize.width), bottom: 5, right: 0)
            }else {
                imageInsets = UIEdgeInsets(top: -24, left: 0, bottom: 0, right: -titleSize.width)
                titleInsets = UIEdgeInsets(top: (imageSize.height + spacing),
                                           left: -(imageSize.width), bottom: 5, right: 0)
            }
        case .left:
            if num == 0 {
                titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
                imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                           right: -(titleSize.width * 2 + spacing))
            }else {
                titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
                imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                           right: -(titleSize.width * 2 + spacing))
            }
            
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}

extension UIView {

    func addOnClickListener(target: AnyObject, action: Selector) {
        let gr = UITapGestureRecognizer(target: target, action: action)
        gr.numberOfTapsRequired = 1
        isUserInteractionEnabled = true
        addGestureRecognizer(gr)
    }

}
