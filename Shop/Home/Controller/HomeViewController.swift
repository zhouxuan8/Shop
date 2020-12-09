//
//  HomeViewController.swift
//  LiveWarmFamily
//
//  Created by 周璇 on 2020/9/27.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    lazy var viewModel = HomeViewModel()
    var collect: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData { (isSuccess) in
            self.collect.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

}

extension HomeViewController {
    override func setupUI() {
        let layout = UICollectionViewFlowLayout()
        collect = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: UIScreen.main.bounds.height - 48 - (glt_iphoneX ? 34 : 0)), collectionViewLayout: layout)
        collect.backgroundColor = .white
        collect.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifiers)
        collect.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderView.header)
        collect.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifiers)
        collect.delegate = self
        collect.dataSource = self
        view.addSubview(collect)
    }
}

// MARK: - ====== 代理实现 ======
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifiers, for: indexPath)
        cell.dict = viewModel.list[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderView.header, for: indexPath) as! HomeHeaderView
        return header
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 10)/2
        return CGSize(width: width, height: width + 75)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 500)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
