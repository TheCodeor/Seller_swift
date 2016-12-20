//
//  RequestModel.swift
//  Seller_swift
//
//  Created by fanpeng on 16/12/14.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import UIKit

enum RequestState {
    case success
    case failture
}

class RequestModel: NSObject {
    
    let code: Int?
    let msg: String?
    let data: [String : Any]?
    let debug: String?
    let reqeustState: RequestState

    init(Json:NSDictionary) {
        
        self.code = Json.object(forKey: "code") as? Int ?? 9999
        self.msg = Json.object(forKey: "msg") as? String
        self.data = Json["data"] as? [String : Any]
        self.debug = Json.object(forKey: "debug") as? String
        
        if self.code == 0 {
            self.reqeustState = .success
        } else {
            self.reqeustState = .failture
        }
    }

}
