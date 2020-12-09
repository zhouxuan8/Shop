//
//  HomeCollectionViewCell.swift
//  LiveWarmFamily
//
//  Created by 周璇 on 2020/9/29.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifiers = "HomeCollectionViewCell"
    lazy var base = BaseViewController()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      configBaseView()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    func configBaseView() {
        backgroundColor = .clear
        addSubview(img)
        addSubview(title)
        addSubview(money)
        addSubview(line)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    lazy var img: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var title: UILabel = {
        let lab = UILabel(frame: CGRect(x: 10, y: img.frame.height + 10, width: bounds.width - 20, height: 15))
        lab.font = UIFont.boldSystemFont(ofSize: 15)
        lab.textColor = UIColor.black
        return lab
    }()
    
    lazy var money: UILabel = {
        let lab = UILabel(frame: CGRect(x: title.frame.origin.x, y: title.frame.origin.y + title.frame.height + 5, width: title.frame.width, height: 20))
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = UIColor.red
        return lab
    }()
    lazy var line: UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: bounds.height - 0.5, width: bounds.width, height: 0.5))
        lab.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return lab
    }()
    
    var dict: [String: AnyObject]? {
        didSet {
            let imgStr = dict?["img"] as? String ?? ""
            let titleStr = dict?["title"] as? String ?? ""
            let moneyStr = dict?["money"] as? String ?? ""
            img.image = UIImage(named: imgStr)
            title.text = titleStr
            let str = NSMutableAttributedString.init(string: "¥" + moneyStr)
            str.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 20), range: NSRange(location: 0, length: 1))
            money.attributedText = str
        }
    }
}

