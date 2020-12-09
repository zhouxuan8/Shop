//
//  CaseDetailModel.swift
//  LiveWarmFamily
//
//  Created by apple on 2020/11/19.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class CaseDetailModel: NSObject {

    var case_id = ""
    var title = ""
    var acreage = ""
    var apart_name = "" //几室
    var apartment_id = ""
    var style_name = ""
    var style_id = ""
    var local_name = ""   //局部
    var local_id = ""   //局部
    var space_name = ""   //空间
    var space_id = ""   //空间
    var designer_name = ""
    var designer_id = ""
    var browse_num = ""
    var name = ""
    var logo = ""
    var is_follow = false
    var is_own = false
    var is_collection = false
    var remark = ""
    var nickname = ""
    var user_id = ""
    var files: [[String: AnyObject]] = []
    
    init(dic:[String:AnyObject]) {
        super.init()
        //模型一键赋值这个其实是运用了kvc的原理
        self.setValuesForKeys(dic)
        case_id = dic["id"] as? String ?? ""
        title = dic["title"] as? String ?? ""
        acreage = dic["acreage"] as? String ?? ""
        apart_name = dic["apart_name"] as? String ?? ""
        apartment_id = dic["apartment_id"] as? String ?? ""
        style_name = dic["style_name"] as? String ?? ""
        style_id = dic["style_id"] as? String ?? ""
        local_name = dic["local_name"] as? String ?? ""
        local_id = dic["local_id"] as? String ?? ""
        space_name = dic["space_name"] as? String ?? ""
        space_id = dic["space_id"] as? String ?? ""
        designer_name = dic["designer_name"] as? String ?? ""
        designer_id = dic["designer_id"] as? String ?? ""
        browse_num = dic["browse_num"] as? String ?? ""
        name = dic["name"] as? String ?? ""
        logo = dic["logo"] as? String ?? ""
        is_follow = dic["is_follow"] as? Bool ?? false
        is_own = dic["is_own"] as? Bool ?? false
        is_collection = dic["is_collection"] as? Bool ?? false
        remark = dic["remark"] as? String ?? ""
        nickname = dic["nickname"] as? String ?? ""
        user_id = dic["user_id"] as? String ?? ""
        files = dic["files"] as? [[String: AnyObject]] ?? []
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
    }
    
}
