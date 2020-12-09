//
//  VideoModel.swift
//  LiveWarmFamily
//
//  Created by apple on 2020/11/4.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class VideoModel: NSObject {
    
    var name = ""
    var content = ""
    var codeImg = ""
    var title = ""
    var img = ""
    var file_path = ""
    var praise_num = ""

    init(dic:[String:AnyObject]) {
        super.init()
        //模型一键赋值这个其实是运用了kvc的原理
        self.setValuesForKeys(dic)
        name = dic["name"] as? String ?? ""
        content = dic["content"] as? String ?? ""
        codeImg = dic["codeImg"] as? String ?? ""
        img = dic["img"] as? String ?? ""
        title = dic["title"] as? String ?? ""
        file_path = dic["file_path"] as? String ?? ""
        praise_num = dic["praise_num"] as? String ?? ""
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
    }
}
