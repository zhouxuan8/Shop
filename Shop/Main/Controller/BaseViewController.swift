//
//  WBBaseViewController.swift
//  微博
//
//  Created by 周璇 on 2016/11/10.
//  Copyright © 2016年 周璇. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    

    let xframe = UIApplication.shared.statusBarFrame
    let glt_iphoneX = (UIScreen.main.bounds.height >= 812.0)

    // left drawer delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .bottom
        setupUI()
        setBackColor()
    }
    
}


//MARK:-设置界面
extension BaseViewController {
    
    @objc func setupUI() {
        view.endEditing(true)
    }
    
    @objc func setBackColor() {
        view.backgroundColor = UIColor.white
    }
    
    
    
}



extension String {
    func mySubString(to index: Int) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    
    func mySubString(from index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    
    //从0索引处开始查找是否包含指定的字符串，返回Int类型的索引
     //返回第一次出现的指定子字符串在此字符串中的索引
    func findFirst(_ sub:String)->Int {
        var pos = -1
        if let range = range(of:sub, options: .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
    /// NSRange转化为range
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
          return from ..< to
    }
}



extension UIImage {
    /// 获取网络图片尺寸
    ///
    /// - Parameter url: 网络图片链接
    /// - Returns: 图片尺寸size
    class func getImageSize(_ url: String?) -> CGSize {
        guard let urlStr = url else {
            return CGSize.zero
        }
        let tempUrl = URL(string: urlStr) ?? URL.init(fileURLWithPath: "")
        let imageSourceRef = CGImageSourceCreateWithURL(tempUrl  as CFURL, nil)
        var width: CGFloat = 0
        var height: CGFloat = 0
        if let imageSRef = imageSourceRef {
            let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSRef, 0, nil)
            if let imageP = imageProperties {
                let imageDict = imageP as Dictionary
                width = imageDict[kCGImagePropertyPixelWidth] as! CGFloat
                height = imageDict[kCGImagePropertyPixelHeight] as! CGFloat
            }
        }
        return CGSize(width: width, height: height)
    }
}

public extension UIView {
    
    // MARK: 添加渐变色图层
    func gradientColor(_ startPoint: CGPoint, _ endPoint: CGPoint, _ colors: [Any], _ bounds: CGRect) {
        
        guard startPoint.x >= 0, startPoint.x <= 1, startPoint.y >= 0, startPoint.y <= 1, endPoint.x >= 0, endPoint.x <= 1, endPoint.y >= 0, endPoint.y <= 1 else {
            return
        }
        
        // 外界如果改变了self的大小，需要先刷新
        layoutIfNeeded()
        
        var gradientLayer: CAGradientLayer!
        
        removeGradientLayer()

        gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.masksToBounds = true
        // 渐变图层插入到最底层，避免在uibutton上遮盖文字图片
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.backgroundColor = UIColor.clear
        // self如果是UILabel，masksToBounds设为true会导致文字消失
        self.layer.masksToBounds = false
    }
    
    // MARK: 移除渐变图层
    // （当希望只使用backgroundColor的颜色时，需要先移除之前加过的渐变图层）
    func removeGradientLayer() {
        if let sl = self.layer.sublayers {
            for layer in sl {
                if layer.isKind(of: CAGradientLayer.self) {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    //设置阴影
    //预设一组常用的参数
    func setShadow(color:CGColor = UIColor.darkGray.cgColor,
                          offset:CGSize = CGSize(width: 2, height: 2),
                          radius:CGFloat = 5,
                          opacity:Float = 1){
        self.layer.shadowColor = color
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
    }
}
