//
//  OrderDetialViewController.swift
//  Seller_swift
//
//  Created by fanpeng on 17/2/4.
//  Copyright © 2017年 fanpeng. All rights reserved.
//

import UIKit

class OrderDetialViewController: UIViewController {
    
    var orderId = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DLog(message: orderId)
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
