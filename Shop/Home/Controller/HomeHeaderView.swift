//
//  HomeHeaderView.swift
//  LiveWarmFamily
//
//  Created by 周璇 on 2020/9/30.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class HomeHeaderView: UICollectionReusableView {
    static let header = "HomeHeaderViewId"
    override init(frame: CGRect) {
      super.init(frame: frame)
      configBaseView()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    func configBaseView() {
        self.clipsToBounds = true
        addSubview(banner)
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
        backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
    }
    
    lazy var banner: ZCycleView = {
        let bannerView = ZCycleView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 250))
        bannerView.itemSize = bannerView.frame.size
        bannerView.timeInterval = 3
        bannerView.scrollDirection = .horizontal
        bannerView.delegate = self
        bannerView.setImagesGroup([UIImage(named: "banner"), UIImage(named: "banner"), UIImage(named: "banner")])
        return bannerView
    }()
    
    lazy var btnView: UIView = {
        let view = UIView(frame: CGRect(x: 15.0, y: banner.frame.height - 30, width: bounds.width - 30.0, height: 110))
        view.backgroundColor = UIColor.white
        view.setShadow(color: UIColor(red: 0.15, green: 0.57, blue: 0.93, alpha: 1).cgColor, offset: CGSize(width: 0, height: 0), radius: 5, opacity: 0.19)
        view.layer.cornerRadius = 10.0
        let scView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height))
        scView.backgroundColor = .clear
        scView.contentSize = CGSize(width: (bounds.width - 30.0)*2.0, height: view.frame.height)
        scView.alwaysBounceHorizontal = true
        scView.isPagingEnabled = true
        scView.showsHorizontalScrollIndicator = false
        scView.delegate = self
        view.addSubview(scView)
        let strList = ["积分兑股权", "网络县长", "占村为王", "越拼越多", "共享代理", "商通百年", "共享红包", "开店申请", "村长公益", "人人送", "共享教育", "村长直播", "村长田园", "村长养殖", "村长种植", "村长直营", "村长云仓", "村长网仓", "村长助企", "村长实体"]
        for i in 0..<strList.count {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: view.frame.width/5.0 * CGFloat(i%5) + view.frame.width * CGFloat(i/10), y: view.frame.height/2 , width: (UIScreen.cz_screenWidth() - 30.0)/5.0, height: 80)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(UIColor.color(hex: TextBaseColor), for: .normal)
            button.set(image: UIImage(named: imgStrList[i]), title: strList[i], titlePosition: .bottom, additionalSpacing: 10.0, state: .normal, num: 0)
            button.tag = i
            scView.addSubview(button)
        }
        return view
    }()
    
}
extension HomeHeaderView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension HomeHeaderView: ZCycleViewProtocol {
    func cycleViewConfigureDefaultCellImage(_ cycleView: ZCycleView, imageView: UIImageView, image: UIImage?, index: Int) {
        imageView.image = image
    }
    func cycleViewConfigureDefaultCellImageUrl(_ cycleView: ZCycleView, imageView: UIImageView, imageUrl: String?, index: Int) {
        
    }
    func cycleViewConfigurePageControl(_ cycleView: ZCycleView, pageControl: ZPageControl) {
        pageControl.alignment = .center
        pageControl.spacing = 10
        pageControl.dotSize = CGSize(width: 5, height: 5)
        pageControl.currentDotSize = CGSize(width: 10, height: 5)
        pageControl.pageIndicatorTintColor = UIColor.blue
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.spacing = 5.0
    }
    
    func cycleViewDidSelectedIndex(_ cycleView: ZCycleView, index: Int) {
        
    }
}
