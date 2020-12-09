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
    var viewList: [UIView] = []
    var timer: Timer!
    var number = 3
    var isFirst = true
    
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
        addSubview(sreachView)
        addSubview(btnView)
        addSubview(pageControl)
        addSubview(btnView1)
        addSubview(msgBanner)
        addSubview(goodBanner)
        addSubview(imgView)
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
    }
    
    @objc func tickDown() {
        for i in 0..<viewList.count {
            if viewList[i].isUserInteractionEnabled {
                UIView.animate(withDuration: 0.5) {
                    self.viewList[(i + 1)%self.number].frame.origin.x = self.isFirst ? 70 : 70 + self.viewList[i].frame.width * 0.1
                    self.viewList[(i + 1)%self.number].transform = CGAffineTransform(scaleX: 1.0 , y: 1.0)
                    self.viewList[(i + 1)%self.number].isUserInteractionEnabled = true
                    self.goodBanner.bringSubviewToFront(self.viewList[(i + 1)%self.number])
                    self.viewList[(i + 2)%self.number].frame.origin.x = self.isFirst ? 130 : 130 + self.viewList[i].frame.width * 0.05
                    self.viewList[(i + 2)%self.number].transform = CGAffineTransform(scaleX: 0.8 , y: 0.8)
                    self.viewList[i].frame.origin.x = self.isFirst ? 100 : 100 - self.viewList[i].frame.width * 0.0
                    self.viewList[i].transform = CGAffineTransform(scaleX: 0.9 , y: 0.9)
                    self.viewList[i].isUserInteractionEnabled = false
                    self.isFirst = false
                }
                break
            }
        }
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
        backgroundColor = .white
    }
    
    lazy var banner: ZCycleView = {
        let bannerView = ZCycleView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 200))
        bannerView.itemSize = bannerView.frame.size
        bannerView.timeInterval = 3
        bannerView.scrollDirection = .horizontal
        bannerView.delegate = self
        bannerView.setImagesGroup([UIImage(named: "banner"), UIImage(named: "banner"), UIImage(named: "banner")])
        return bannerView
    }()
    
    lazy var sreachView: UIView = {
        let view = UIView(frame: CGRect(x: bounds.width - 200, y: 15, width: 185, height: 30))
        view.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        view.layer.cornerRadius = view.frame.height/2
        view.layer.masksToBounds = true
        let img = UIImageView(frame: CGRect(x: 15, y: 10, width: 15, height: 10))
        img.image = UIImage(named: "loadingImg")
        view.addSubview(img)
        let line = UILabel(frame: CGRect(x: 45, y: 5, width: 0.5, height: 20))
        line.backgroundColor = UIColor.gray
        view.addSubview(line)
        let btn = UIButton(frame: CGRect(x: 60, y: 0, width: view.frame.width - 75, height: view.frame.height))
        btn.setImage(UIImage(named: "icon-search"), for: .normal)
        btn.setTitle(" 2020夏季碎花裙", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(btn)
        return view
    }()
    
    lazy var btnView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: banner.frame.height - 30, width: bounds.width - 20, height: 180))
        view.backgroundColor = UIColor.white
        view.setShadow(color: UIColor(red: 0.15, green: 0.57, blue: 0.93, alpha: 1).cgColor, offset: CGSize(width: 0, height: 0), radius: 5, opacity: 0.19)
        view.layer.cornerRadius = 10.0
        let scView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height))
        scView.backgroundColor = .clear
        scView.contentSize = CGSize(width: view.frame.width*2.0, height: view.frame.height)
        scView.alwaysBounceHorizontal = true
        scView.isPagingEnabled = true
        scView.showsHorizontalScrollIndicator = false
        scView.delegate = self
        view.addSubview(scView)
        let strList = ["积分兑股权", "网络县长", "占村为王", "越拼越多", "共享代理", "商通百年", "共享红包", "开店申请", "村长公益", "人人送", "共享教育", "村长直播", "村长田园", "村长养殖", "村长种植", "村长直营", "村长云仓", "村长网仓", "村长助企", "村长实体"]
        var y: CGFloat = 0
        for i in 0..<strList.count {
            if i/5 == 1 || i/5 == 3 {
                y = view.frame.height/2
            }else {
                y = 0
            }
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: view.frame.width/5.0 * CGFloat(i%5) + view.frame.width * CGFloat(i/10), y: y, width: view.frame.width/5.0, height: view.frame.height/2)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.setTitleColor(UIColor.black, for: .normal)
            button.set(image: UIImage(named: "shop_\(i%8 + 1)"), title: strList[i], titlePosition: .bottom, additionalSpacing: 0, state: .normal, num: 1)
            scView.addSubview(button)
        }
        return view
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: btnView.frame.origin.y + btnView.frame.height, width: bounds.width, height: 25))
        //页控件属性
        pageControl.backgroundColor = UIColor.clear
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        //设置pageControl未选中的点的颜色
        pageControl.pageIndicatorTintColor = UIColor.gray
        //设置pageControl选中的点的颜色
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    lazy var btnView1: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: pageControl.frame.origin.y + pageControl.frame.height + 20, width: bounds.width, height: 50))
        view.backgroundColor = .clear
        let strList = ["到店距离", "新手指南", "关注公众号", "下载APP"]
        let color = [UIColor(red: 0.55, green: 0.27, blue: 0.07, alpha: 1), UIColor(red: 0.55, green: 0.23, blue: 0.23, alpha: 1), UIColor(red: 0.74, green: 0.56, blue: 0.56, alpha: 1), UIColor(red: 0, green: 0.4, blue: 0, alpha: 1)]
        let width = (bounds.width - 4 * 10)/4
        for i in 0..<strList.count {
            let btn = UIButton(frame: CGRect(x: 5 + (width + 10) * CGFloat(i), y: 0, width: width, height: view.frame.height))
            btn.layer.cornerRadius = 10
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            btn.setTitle(strList[i], for: .normal)
            btn.setTitleColor(color[i], for: .normal)
            view.addSubview(btn)
            btn.backgroundColor = color[i].withAlphaComponent(0.5)
        }
        return view
    }()
    
    lazy var msgBanner: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: btnView1.frame.origin.y + btnView1.frame.height + 10, width: bounds.width, height: 35))
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        let lab = UILabel(frame: CGRect(x: 10, y: 0, width: 60, height: view.frame.height))
        lab.font = UIFont.boldSystemFont(ofSize: 12)
        lab.text = "共享村长"
        lab.textColor = UIColor(red: 1, green: 0.75, blue: 0.14, alpha: 1)
        let str = NSMutableAttributedString.init(string: lab.text ?? "")
        str.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: 2))
        lab.attributedText = str
        view.addSubview(lab)
        let line = UILabel(frame: CGRect(x: 65, y: 10, width: 0.5, height: 15))
        line.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        view.addSubview(line)
        let img = UIImageView(frame: CGRect(x: 75, y: 12, width: 11, height: 11))
        img.image = UIImage(named: "icon-tongzhi")
        view.addSubview(img)
        let msgBanner = ZCycleView(frame: CGRect(x: 90, y: 0, width: bounds.width - 95, height: view.frame.height))
        msgBanner.itemSize = msgBanner.frame.size
        msgBanner.scrollDirection = .vertical
        msgBanner.setTitlesGroup(["签到有积分", "这是第一个内容", "这是第二个内容"])
        msgBanner.delegate = self
        view.addSubview(msgBanner)
        return view
    }()
    
    lazy var goodBanner: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: msgBanner.frame.origin.y + msgBanner.frame.height, width: bounds.width, height: 130))
        view.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
        let lab = UILabel(frame: CGRect(x: 10, y: 40, width: 80, height: 50))
        lab.text = "商品\n排行"
        lab.numberOfLines = 0
        lab.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
        lab.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(lab)
        let jtView = UIView(frame: CGRect(x: 10, y: lab.frame.origin.y + lab.frame.height, width: 40, height: 20))
        jtView.gradientColor(CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), [UIColor(red: 1, green: 0.65, blue: 0.31, alpha: 1).cgColor, UIColor(red: 1, green: 0.84, blue: 0, alpha: 0.5).cgColor], CGRect(x: 0, y: 0, width: jtView.frame.width, height: jtView.frame.size.height))
        jtView.layer.cornerRadius = jtView.frame.height/2
        jtView.layer.masksToBounds = true
        view.addSubview(jtView)
        let jt = UILabel(frame: jtView.bounds)
        jt.font = UIFont.systemFont(ofSize: 14)
        jt.textAlignment = .center
        jt.text = ">>"
        jt.textColor = UIColor.white
        jtView.addSubview(jt)
        for i in 0..<number {
            let goodView = UIView(frame: CGRect(x: 70, y: 10, width: view.frame.width - 120, height: view.frame.height - 30))
            goodView.backgroundColor = UIColor.white
            goodView.tag = i
            view.addSubview(goodView)
            goodView.isUserInteractionEnabled = false
            if i == number - 1 {
                goodView.isUserInteractionEnabled = true
            }
            let lab = UILabel(frame: CGRect(x: 15, y: 15, width: 60, height: 20))
            lab.layer.cornerRadius = lab.frame.height/2
            lab.layer.masksToBounds = true
            lab.backgroundColor = UIColor.red
            lab.text = "热销产品"
            lab.textAlignment = .center
            lab.textColor = UIColor.white
            lab.font = UIFont.systemFont(ofSize: 12)
            goodView.addSubview(lab)
            let title = UILabel(frame: CGRect(x: lab.frame.origin.x, y: lab.frame.origin.y + lab.frame.height + 10, width: goodView.frame.width - 100, height: 13))
            title.text = "这是产品的名称"
            title.font = UIFont.systemFont(ofSize: 13)
            title.textColor = .black
            goodView.addSubview(title)
            let money = UILabel(frame: CGRect(x: lab.frame.origin.x, y: title.frame.origin.y + title.frame.height + 10, width: title.frame.width, height: 12))
            money.text = "¥1999.00"
            money.textColor = UIColor.gray
            money.font = UIFont.systemFont(ofSize: 12)
            goodView.addSubview(money)
            let img = UIImageView(frame: CGRect(x: goodView.frame.width - 85, y: 15, width: 70, height: 70))
            img.image = UIImage(named: "banner")
            img.contentMode = .scaleAspectFit
            goodView.addSubview(img)
            viewList.append(goodView)
        }
        return view
    }()
    
    lazy var imgView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: goodBanner.frame.origin.y + goodBanner.frame.height, width: bounds.width, height: 180))
        view.backgroundColor = .clear
        let img = UIImageView(frame: CGRect(x: 10, y: 10, width: view.frame.width - 20, height: view.frame.height - 30))
        img.image = UIImage(named: "banner")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        view.addSubview(img)
        let line = UILabel(frame: CGRect(x: 0, y: view.frame.height - 10, width: view.frame.width, height: 10))
        line.backgroundColor = goodBanner.backgroundColor
        view.addSubview(line)
        return view
    }()
    
}
extension HomeHeaderView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / (bounds.width - 20))
        //设置pageController的当前页
        pageControl.currentPage = page
    }
}

extension HomeHeaderView: ZCycleViewProtocol {
    func cycleViewConfigureDefaultCellImage(_ cycleView: ZCycleView, imageView: UIImageView, image: UIImage?, index: Int) {
        imageView.image = image
    }
    func cycleViewConfigureDefaultCellImageUrl(_ cycleView: ZCycleView, imageView: UIImageView, imageUrl: String?, index: Int) {
        
    }
    func cycleViewConfigureDefaultCellText(_ cycleView: ZCycleView, titleLabel: UILabel, index: Int) {
        titleLabel.textAlignment = .center
    }
    func cycleViewConfigurePageControl(_ cycleView: ZCycleView, pageControl: ZPageControl) {
        pageControl.frame.origin.y = cycleView.frame.height - 55
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
