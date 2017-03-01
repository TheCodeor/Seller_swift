//
//  LoginViewController.swift
//  Seller_swift
//
//  Created by fanpeng on 16/12/20.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import CoreData
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var pswField: UITextField!
    @IBOutlet weak var forgetPswButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        phoneField.text = "13750440152"
        pswField.text = "123456789"
        
     }


    // MARK: - ACTION
    @IBAction func actionLogin(_ sender: Any) {
        
        let parameters: Parameters = ["mobile": phoneField.text!,
                                      "pwd": pswField.text!]
            
        NetworkRequest.sharedInstance.postRequest("user.login", params: parameters, success: { response in
            
            switch response.reqeustState {
            case .success:
                
                var userInfo = response.data?.dictionaryObject
                userInfo?["token"] = response.token
                userInfo?["userId"] = response.userId
                
                userDefault.set(userInfo, forKey: "userInfo")
                userDefault.synchronize()
                
                let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                appDelegate.window?.rootViewController = storyBoard.instantiateInitialViewController()

            case.failture:
                
                DLog(message: response.msg)
            }

        }, failture: { error in })
        
    }

    @IBAction func actionForgetPsw(_ sender: Any) {
        deleteAllUserCoreData()
        printAllDataWithUserCoreData()
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
