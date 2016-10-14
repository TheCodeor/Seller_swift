//
//  OrderTableViewCell.swift
//  Seller_swift
//
//  Created by fanpeng on 16/10/13.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    var topView = UIView()
    let orderNumberLabel = UILabel()
    let dateLabel = UILabel()
    let nameLabel = UILabel()
    let statusLabel = UILabel()
    let detailLabel = UILabel()
    let endLabel = UILabel()


    // Class 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.colorWithHexString(hex: "ababab")
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 2.0
        bgView.layer.borderColor = UIColor.colorWithHexString(hex: "ababab").cgColor
        bgView.layer.borderWidth = 1.0
        self.contentView.addSubview(bgView)
        
        bgView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).offset(0)
            make.right.equalTo(self.contentView).offset(-10)
        }
        
        topView = self.creatTopView()
        bgView.addSubview(topView)

        let middleView = self.creatMiddleView()
        bgView.addSubview(middleView)
    
        let bottomView = creatBottomView()
        bgView.addSubview(bottomView)
        
        topView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(bgView)
            make.height.equalTo(40)
        }
        
        middleView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(bgView)
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(bottomView.snp.top).offset(-1)
        }
        
        bottomView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(bgView)
            make.bottom.equalTo(bgView)
            make.height.equalTo(40)
        }
        
 
    }
    
    func creatTopView() -> UIView {
        
        let view = UIView()
        view.backgroundColor = UIColor.colorWithHexString(hex: "fc0d1b")
        
        let topLabelView = UIView()
        topLabelView.backgroundColor = UIColor.white
        view.addSubview(topLabelView)
        
        orderNumberLabel.text = "#17122"
        orderNumberLabel.textColor = UIColor.colorWithHexString(hex: "fc0d1b")
        topLabelView.addSubview(orderNumberLabel)
        
        
        dateLabel.text = "下单时间:2016-09-27 15:22:24"
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = UIColor.colorWithHexString(hex: "fc0d1b")
        topLabelView.addSubview(dateLabel)
        
        topLabelView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(10)
            make.left.right.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(-1)
            
        }
        
        orderNumberLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(topLabelView)
            make.left.equalTo(topLabelView).offset(5)
        }
        
        dateLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(topLabelView)
            make.right.equalTo(topLabelView).offset(-5)
        }
        
        return view
    }
    
    func creatMiddleView() -> UIView {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        nameLabel.text = "测试"
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(view)
            make.left.equalTo(view).offset(5)
        }
        
        statusLabel.text = "已付款"
        statusLabel.textColor = UIColor.colorWithHexString(hex: "4b9ce3")
        view.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(view)
            make.right.equalTo(view).offset(-5)
        }
        
        return view
    }
    
    func creatBottomView() -> UIView {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        detailLabel.text = "实收：0.00元（含配送费）"
        detailLabel.textColor = UIColor.colorWithHexString(hex: "dcdcdc")
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(view)
            make.left.equalTo(view).offset(5)
        }
        
        endLabel.text = "已付款"
        endLabel.font = UIFont.systemFont(ofSize: 14)
        endLabel.textColor = UIColor.colorWithHexString(hex: "dcdcdc")
        view.addSubview(endLabel)
        endLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(view)
            make.right.equalTo(view).offset(-5)
        }
        
        return view
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        fatalError("init(coder:) has not been implemented")
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
