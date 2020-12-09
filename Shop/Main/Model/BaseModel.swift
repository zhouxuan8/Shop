//
//  BaseModel.swift
//  LiveWarmFamily
//
//  Created by apple on 2020/11/10.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    var code = ""
    var msg = ""
    var list: [String: AnyObject] = [:]
    
    init(dic:[String:AnyObject]) {
        super.init()
        //模型一键赋值这个其实是运用了kvc的原理
        self.setValuesForKeys(dic)
        code = dic["code"] as? String ?? ""
        msg = dic["msg"] as? String ?? ""
        list = dic["list"] as? [String: AnyObject] ?? [:]
    }
    override func setValue(_ value: Any?, forKey key: String) {
        
    }
}
