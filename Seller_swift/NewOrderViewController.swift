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
    var pageCount = 1
    var orderList:[OrdersModel] = []
    
    @IBOutlet weak var orderTableView: UITableView!
    
    func creatTableView() {
        orderTableView.rowHeight = 140.0
    }
    
    func creatTableViewHeader(orderNumber: String, totalPrice: String) -> UIView {
        
        let label = UILabel(frame:CGRect(x: 0, y: 0, width: 320, height: 44))
        label.font = UIFont.systemFont(ofSize: 15)
        
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
        
        let parameters: Parameters = ["status": 2,"page": pageCount]
        NetworkRequest.sharedInstance.postRequest("order.lists", params: parameters, success: { response in
            
            switch response.reqeustState {
            case .success:
                let newOrderModel = NewOrderModel(dataJson: response.data!)
                if !newOrderModel.ordersList.isEmpty {
                    self.orderList += newOrderModel.ordersList
                } else {
                    self.orderTableView.es_noticeNoMoreData()
                }
                
                
                self.orderTableView.tableHeaderView = self.creatTableViewHeader(orderNumber: newOrderModel.count!, totalPrice: newOrderModel.amount!)
            case.failture:
                DLog(message: "faile")
            }
            self.orderTableView.reloadData()
            self.orderTableView.es_stopPullToRefresh(ignoreDate: true)
            self.orderTableView.es_stopLoadingMore()

        }, failture: { error in })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "新订单"
        
        creatTableView()

        requestOrderLists()
        
        self.orderTableView.es_addPullToRefresh {
            [weak self] in
            self?.orderList.removeAll()
            self?.requestOrderLists()
        }
        
        self.orderTableView.es_addInfiniteScrolling {
            [weak self] in
            /// 在这里做加载更多相关事件
            /// ...
            self?.pageCount += 1
            self?.requestOrderLists()
            /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
//            self?.orderTableView.es_stopLoadingMore()
//            /// 通过es_noticeNoMoreData()设置footer暂无数据状态

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: initIdentifier) as! OrderTableViewCell
        
        if self.orderList.count != 0 {
            let ordersModel = self.orderList[indexPath.row]
            cell.setCellData(ordersModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DLog(message: "点击了\(indexPath.row)行")
        let orderModel = self.orderList[indexPath.row]
        self.performSegue(withIdentifier: "OrderDetialViewController", sender: orderModel.orderId)
    }
    
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        if segue.identifier == "OrderDetialViewController" {
            let orderDetialVC = segue.destination as! OrderDetialViewController
            orderDetialVC.orderId = sender as! Int
        }
     }

}
