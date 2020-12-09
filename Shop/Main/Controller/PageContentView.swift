//
//  PageContentView.swift
//  FcDYZB
//
//  Created by FC on 16/11/11.
//  Copyright © 2016年 JKB. All rights reserved.
//

import UIKit

// 协议代理
protocol PageContentViewDelegate: class{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

fileprivate let contentReuseIdentifier = "contentReuseIdentifier"

class PageContentView: UIView {
// MARK:- 属性区
    /** 控制器数组 */
    fileprivate var childVcs: [UIViewController]
    /** 控制器 */
    fileprivate weak var parentViewcontrol: UIViewController?
    /** collectionView偏移量 */
    fileprivate var startOffsetX: CGFloat = 0
    /** 是否需要禁止执行代理方法 */
    fileprivate var isForbidScorllDelegate: Bool = false
    /** PageContentView代理属性 */
    weak var delegate: PageContentViewDelegate?
    
// MARK:- 懒加载区
     /** 懒加载UICollectionView */
     lazy var collectionView: UICollectionView = {[weak self] in
        // 1、创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        // 2、创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false // 不超出内容的滚动区域
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentReuseIdentifier)
        return collectionView
    }()
    
// MARK:- 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewcontrol:UIViewController?) {
        self.childVcs = childVcs
        self.parentViewcontrol = parentViewcontrol
        super.init(frame: frame)
        
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI
extension PageContentView{
    /** 设置UI */
    fileprivate func setupUI(){
        // 1、把控制器数组中遍历出来的所有控制做为子控制器添加到父控制器上
        for childVc in childVcs {
            parentViewcontrol?.addChild(childVc)
        }
        // 2、添加UICollectionView，用于，在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK:- 实现<UICollectionViewDataSource/Delegate>方法
extension PageContentView:UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1、创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentReuseIdentifier, for: indexPath)
        // 2、给cell设置内容
        for view in cell.contentView.subviews {
            // 因为重复添加，所以还是删除比较好
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
    
    // 监听collectionView开始滚动。 获取偏移量
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 当开始滚到的时候不需要禁止
        isForbidScorllDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    // 监听collectionView滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0、判断是否是点击事件
        if isForbidScorllDelegate {
            return
        }
        // 1、定义获取需要的数据
        var progress: CGFloat = 0 // 滑动了多少(进度)
        var sourceIndex: Int = 0  // 当前在哪个上进行滑动
        var targetIndex: Int = 0  // 滑动到下一个目标值
        // 2、判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左滑※※※※※※
            // 1.0、计算左滑progress   floor()系统取整函数
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            // 2.0、计算当前sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            // 3.0、计算当前targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count { // 处理最后数组越界问题
                targetIndex = childVcs.count - 1
            }
            // 4.0、如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{// 右滑※※※※※※
            // 1.0、计算右滑progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            // 2.0、计算当前targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            // 3.0、计算当前sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        // 3、将progress、sourceIndex、targetIndex传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        //        print("progress:\(progress)  sourceIndex:\(sourceIndex)  targetIndex:\(targetIndex)")
    }
    
    
}

// MARK:- 外部使用方法
extension PageContentView{
    /** 当前选中的下标 */
    func setupCurrentIndex(currentIndex: Int){
        // 1、记录需要禁止
        isForbidScorllDelegate = true
        // 2、滚到正确位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
    }
}
