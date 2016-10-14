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
    var orderList:NSArray = []
    
    // 懒加载
    lazy var datas: [Int] = {
        // 创建一个存放int的数组
        var nums = [Int]()
        // 添加数据
        for i in 0...50 {
            nums.append(i)
        }
        // 返回
        return nums
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "新订单"
        
        let orderTableView = UITableView(frame: self.view.bounds, style: .plain)
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.rowHeight = 133.0
        orderTableView.tableHeaderView = self.creatTableViewHeader()
        self.view.addSubview(orderTableView)

        orderTableView.separatorColor = UIColor.clear
        orderTableView.register(OrderTableViewCell.self, forCellReuseIdentifier: initIdentifier)
        
        
        let parameters: Parameters = [
            "token": "3vyaVEKLmsML2St3tBgW3qcaCM+Oo63brB+mdJ3S4g0F4JmhTGTadD0wDGZaMqifMLsTbeHs/WsIa6Fkh5It4JPJL7dF/KEUC3HUA2suEDM=",
            "userId": 2798,
            "data": [
                "status": 2,
                "page": 1,
            ]
        ]
        
        
        Alamofire.request("http://api.o2o.zhaioto.com/staff/v1/order.lists", parameters: parameters).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                print(JSON)
                
                let dataDic = JSON.object(forKey: "data") as! NSDictionary
                self.orderList = dataDic.object(forKey: "orders") as! NSArray
                
                orderTableView .reloadData()

            }

            
         }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: initIdentifier) as! OrderTableViewCell
        
        if self.orderList.count != 0 {
            let orderDic = self.orderList.object(at: indexPath.row) as! NSDictionary
            cell.orderNumberLabel.text = "#\(orderDic.object(forKey: "id") as! NSInteger)"
            cell.dateLabel.text = orderDic.object(forKey: "createTime") as? String
            cell.statusLabel.text = orderDic.object(forKey: "orderStatusStr") as? String
            
            let totalFee = String(orderDic.object(forKey: "totalFee") as! Double)
            let detailString = "实收￥\(totalFee)元（含配送费）"
            let attStr = NSMutableAttributedString.init(string: detailString)
            let totalFeeRange = (detailString as NSString).range(of: totalFee)
            attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: totalFeeRange)

            cell.detailLabel.attributedText = attStr

            cell.endLabel.text = orderDic.object(forKey: "payStatusStr") as? String
            
            
            DLog(message: totalFee)
        }
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DLog(message: "点击了\(indexPath.row)行")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
