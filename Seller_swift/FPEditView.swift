//
//  FPEditView.swift
//  Seller_swift
//
//  Created by fanpeng on 16/12/20.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import UIKit

@IBDesignable

class FPEditView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor() {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

}
