//
//  OrderTableViewCell.swift
//  Seller_swift
//
//  Created by fanpeng on 16/10/13.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topView = UIView()
    @IBOutlet weak var orderNumberLabel = UILabel()
    @IBOutlet weak var dateLabel = UILabel()
    @IBOutlet weak var nameLabel = UILabel()
    @IBOutlet weak var statusLabel = UILabel()
    @IBOutlet weak var detailLabel = UILabel()
    @IBOutlet weak var endLabel = UILabel()
    
    func setCellData(_ ordersModel:OrdersModel) {
        
        orderNumberLabel?.text = "#\(ordersModel.orderId!)"
        dateLabel?.text = ordersModel.createTime
        statusLabel?.text = ordersModel.orderStatusStr
        
        let totalFee = String(describing: ordersModel.totalFee!)
        let detailString = "实收￥\(totalFee)元（含配送费）"
        let attStr = NSMutableAttributedString.init(string: detailString)
        let totalFeeRange = (detailString as NSString).range(of: totalFee)
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: totalFeeRange)
        
        detailLabel?.attributedText = attStr
        endLabel?.text = ordersModel.payStatusStr
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
