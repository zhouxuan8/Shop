//
//  ZCycleViewCell.swift
//  ZCycleView
//
//  Created by mengqingzheng on 2017/11/17.
//  Copyright © 2017年 MQZHot. All rights reserved.
//

import UIKit

class ZCycleViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var hotImg: UIImageView!
    var titleLabel: UILabel!
    var onlyText: Bool = false {
        didSet {
            if onlyText {
                titleLabel.frame = contentView.bounds
            } else {
                titleLabel.frame = CGRect(x: 0, y: contentView.bounds.size.height-25, width: contentView.bounds.size.width, height: 25)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImageView()
//        addHotimg()
        addTitleLabel()
    }
    
    private func addImageView() {
        imageView = UIImageView(frame: contentView.bounds)
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    private func addHotimg() {
        hotImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 16))
        hotImg.image = UIImage(named: "remen")
        hotImg.clipsToBounds = true
        contentView.addSubview(hotImg)
    }
    
    private func addTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.clipsToBounds = true
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
