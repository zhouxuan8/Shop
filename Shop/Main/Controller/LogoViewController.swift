//
//  LogoViewController.swift
//  aiis_iOS
//
//  Created by 周璇 on 2020/3/24.
//  Copyright © 2020 周璇. All rights reserved.
//

import UIKit

class LogoViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

}

extension LogoViewController {
    override func setupUI() {
        UIApplication.shared.keyWindow?.rootViewController = MainViewController()
    }
    
}
