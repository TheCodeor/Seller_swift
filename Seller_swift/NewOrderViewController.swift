//
//  NewOrderViewController.swift
//  Seller_swift
//
//  Created by fanpeng on 16/10/13.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire


class NewOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    let initIdentifier = "OrderCell"
    
    var orderList: NSArray = []
    var orderTableView: UITableView!
    
    func creatTableView() {
        
        orderTableView = UITableView(frame: self.view.bounds, style: .plain)
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.rowHeight = 133.0
        orderTableView.tableHeaderView = self.creatTableViewHeader()
        self.view.addSubview(orderTableView)
        
        orderTableView.separatorColor = UIColor.clear
        orderTableView.register(OrderTableViewCell.self, forCellReuseIdentifier: initIdentifier)
    }
    
    func creatTableViewHeader() -> UIView {
        
        let label = UILabel(frame:CGRect(x: 0, y: 0, width: 320, height: 44))
        label.font = UIFont.systemFont(ofSize: 15)
        
        let orderNumber = "22"
        let totalPrice = "0.13"
        let string = "共计\(orderNumber)单，金额\(totalPrice)元"
        
        let attStr = NSMutableAttributedString.init(string: string )
        let orderNumberRange = (string as NSString).range(of: orderNumber)
        let totalPriceRange = (string as NSString).range(of: totalPrice, options: .backwards)
        
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: orderNumberRange)
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: totalPriceRange)
        
        label.attributedText = attStr
        label.textAlignment = .center
        label.backgroundColor = UIColor.colorWithHexString(hex: "f9f9f9")
        
        return label
    }
    
    
    func  requestOrderLists() {
        
        let parameters: Parameters = ["status": 2,"page": 1]
        NetworkRequest.sharedInstance.postRequest("order.lists", params: parameters, success: { response in
            
            switch response.reqeustState {
            case .success:
                let newOrderModel = NewOrderModel(dataJson: response.data!)
                self.orderList = newOrderModel.ordersList as NSArray
            case.failture:
                DLog(message: "faile")
            }
            self.orderTableView.reloadData()
            
        }, failture: { error in })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "新订单"
        
        creatTableView()

        requestOrderLists()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: initIdentifier) as! OrderTableViewCell
        
        if self.orderList.count != 0 {
            let ordersModel = self.orderList.object(at: indexPath.row) as! OrdersModel
            cell.setCellData(ordersModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DLog(message: "点击了\(indexPath.row)行")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
