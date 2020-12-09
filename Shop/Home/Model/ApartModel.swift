//
//  ApartModel.swift
//  LiveWarmFamily
//
//  Created by apple on 2020/11/10.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ApartModel: NSObject {
    
    var apartId = ""
    var name = ""
    
    init(dic:[String:AnyObject]) {
        super.init()
        //模型一键赋值这个其实是运用了kvc的原理
        self.setValuesForKeys(dic)
        name = dic["name"] as? String ?? ""
        apartId = dic["id"] as? String ?? ""
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
    }
}
