//
//  NewOrderModel.swift
//  Seller_swift
//
//  Created by fanpeng on 16/12/14.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import UIKit



class NewOrderModel {
    
    let count: Int?
    let ingCount: Int?
    let amount: Double?
    var ordersList = [OrdersModel]()
    
    init(dataJson:[String : Any]) {
        
        self.count = dataJson["count"] as? Int
        self.ingCount = dataJson["ingCount"] as? Int
        self.amount = dataJson["amount"] as? Double
        let ordersArray = dataJson["orders"] as? NSArray
        
        for order in ordersArray! {
            let orderModel = OrdersModel(ordersJson: order as! [String : Any])
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
    
    
    init(ordersJson:[String : Any]) {
        
        self.orderId = ordersJson["id"] as? Int
        self.orderStatusStr = ordersJson["orderStatusStr"] as? String
        self.totalFee = ordersJson["totalFee"] as? Double
        self.freight = ordersJson["freight"] as? Double
        self.createTime = ordersJson["createTime"] as? String
        self.isFinished = ordersJson["isFinished"] as? Bool
        self.shopName = ordersJson["shopName"] as? String
        self.payStatusStr = ordersJson["payStatusStr"] as? String

    }
}
