//
//  CustomTabBarController.swift
//  Seller_swift
//
//  Created by fanpeng on 16/10/13.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let newOrderVC = NewOrderViewController()
        let manageOrderVC = ManageOrderViewController()
        let storeVC = StoreViewController()
        let myVC = MyViewController()
        
        let newOrderNav = CustomNavController(rootViewController: newOrderVC)
        let manageOrderNav = CustomNavController(rootViewController: manageOrderVC)
        let storeNav = CustomNavController(rootViewController: storeVC)
        let myNav = CustomNavController(rootViewController: myVC)
        
        
        let tabbar1 = UITabBarItem(title: "新订单", image: UIImage.init(named: "order_normal"), selectedImage: UIImage.init(named: "order_selected"))
        let tabbar2 = UITabBarItem(title: "订单管理", image: UIImage.init(named: "ordermng_normal"), selectedImage: UIImage.init(named: "ordermng_selected"))
        let tabbar3 = UITabBarItem(title: "店铺", image: UIImage.init(named: "dp_normal"), selectedImage: UIImage.init(named: "dp_selected"))
        let tabbar4 = UITabBarItem(title: "我的", image: UIImage.init(named: "my_normal"), selectedImage: UIImage.init(named: "my_selected"))
        
        newOrderNav.tabBarItem = tabbar1
        manageOrderNav.tabBarItem = tabbar2
        storeNav.tabBarItem = tabbar3
        myNav.tabBarItem = tabbar4

        self.view.backgroundColor = UIColor.white
        self.tabBar.tintColor = UIColor.colorWithHexString(hex: "f61441")
        self.viewControllers = [newOrderNav,manageOrderNav,storeNav,myNav]
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
    
    func DLog<T> (message: T,fileName:String = #file,funcName:String = #function,lineNum:Int = #line) {
        
        #if DEBUG
            
            let file = (fileName as NSString).lastPathComponent;
            
            print("\(file):\(funcName):\(lineNum):\("打印内容"):\(message)")
            
        #endif
        
    }

}



