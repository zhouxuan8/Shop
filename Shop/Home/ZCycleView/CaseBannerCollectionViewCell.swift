//
//  CaseBannerCollectionViewCell.swift
//  LiveWarmFamily
//
//  Created by apple on 2020/10/14.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class CaseBannerCollectionViewCell: UICollectionViewCell {
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
        addSubview(backView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    lazy var img: UIImageView = {
        let image = UIImageView(frame: bounds)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: bounds.height - 55.0, width: bounds.width, height: 55.0))
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
}
