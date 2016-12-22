//
//  RequestModel.swift
//  Seller_swift
//
//  Created by fanpeng on 16/12/14.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import UIKit
import SwiftyJSON

enum RequestState {
    case success
    case failture
}

class RequestModel: NSObject {
    
    let token: String?
    let userId: Int?
    let code: Int?
    let msg: String?
    let data: JSON?
    let debug: String?
    let reqeustState: RequestState

    init(_ json:JSON) {
        
        self.code = json["code"].intValue
        self.msg = json["msg"].stringValue
        self.data = json["data"]
        self.debug = json["debug"].stringValue
        self.token = json["token"].stringValue
        self.userId = json["userId"].intValue
        
        if self.code == 0 {
            self.reqeustState = .success
        } else {
            self.reqeustState = .failture
        }
    }

}
