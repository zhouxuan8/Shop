//
//  HomeViewModel.swift
//  LiveWarmFamily
//
//  Created by apple on 2020/11/26.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {

    var list: [[String: AnyObject]] = []
    
    func getData(completion:@escaping (_ isSuccess:Bool)->()) {
        cellHeight()
    }
    
    func cellHeight() {
        list = [["img": "img4" as AnyObject, "title": "这是一个香薰 500ML" as AnyObject, "money": "39.00" as AnyObject],
                ["img": "img8" as AnyObject, "title": " 小鹿一家三口" as AnyObject, "money": "39.00" as AnyObject],
                ["img": "img8" as AnyObject, "title": "旧房改造注意事项" as AnyObject, "money": "39.00" as AnyObject],
                ["img": "img4" as AnyObject, "title": "旧房改造注意事项" as AnyObject, "money": "39.00" as AnyObject],
                ["img": "img4" as AnyObject, "title": "旧房改造注意事项" as AnyObject, "money": "39.00" as AnyObject],
                ["img": "img8" as AnyObject, "title": "旧房改造注意事项" as AnyObject, "money": "39.00" as AnyObject],
                ["img": "img4" as AnyObject, "title": "旧房改造注意事项" as AnyObject, "money": "39.00" as AnyObject],
                ["img": "img8" as AnyObject, "title": "旧房改造注意事项" as AnyObject, "money": "39.00" as AnyObject],
                ["img": "img8" as AnyObject, "title": "旧房改造注意事项" as AnyObject, "money": "39.00" as AnyObject],
                ["img": "img4" as AnyObject, "title": "旧房改造注意事项" as AnyObject, "money": "39.00" as AnyObject]]
        
    }
}
