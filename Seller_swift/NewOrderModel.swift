//
//  NewOrderModel.swift
//  Seller_swift
//
//  Created by fanpeng on 16/12/14.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import UIKit
import SwiftyJSON


class NewOrderModel {
    
    let count: Int?
    let ingCount: Int?
    let amount: Double?
    var ordersList = [OrdersModel]()
    
    init(dataJson:JSON) {
        
        self.count = dataJson["count"].intValue
        self.ingCount = dataJson["ingCount"].intValue
        self.amount = dataJson["amount"].doubleValue
        let ordersArray = dataJson["orders"].arrayValue
        
        for order in ordersArray {
            let orderModel = OrdersModel(ordersJson: order)
            self.ordersList.append(orderModel)
        }
    }

}

class OrdersModel {
    
    let orderId: Int?
    let orderStatusStr: String?
    let totalFee: Double?
    let freight: Double?
    let createTime: String?
    let isFinished: Bool?
    let shopName: String?
    let payStatusStr: String?
    
    
    init(ordersJson:JSON) {
        
        self.orderId = ordersJson["id"].intValue
        self.orderStatusStr = ordersJson["orderStatusStr"].stringValue
        self.totalFee = ordersJson["totalFee"].doubleValue
        self.freight = ordersJson["freight"].doubleValue
        self.createTime = ordersJson["createTime"].stringValue
        self.isFinished = ordersJson["isFinished"].boolValue
        self.shopName = ordersJson["shopName"].stringValue
        self.payStatusStr = ordersJson["payStatusStr"].stringValue

    }
}
