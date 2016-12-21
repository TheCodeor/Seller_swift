//
//  Seller_swiftTests.swift
//  Seller_swiftTests
//
//  Created by fanpeng on 16/10/12.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import XCTest
import Alamofire

@testable import Seller_swift

class Seller_swiftTests: XCTestCase {
    
    var vc: LoginViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoginRequestApi() {
       
        _ = vc.view

        let extion = expectation(description: "login request test")
        let timeout = 15 as TimeInterval

        let parameters: Parameters = ["mobile": vc.phoneField.text!,
                                      "pwd": vc.pswField.text!]
        
       NetworkRequest.sharedInstance.postRequest("user.login", params: parameters, success: { response in

            XCTAssertTrue(response.reqeustState == .success)
            extion.fulfill()

            switch response.reqeustState {
            case .success: break
            case .failture: break
            }
            
        }, failture: { error in })
        waitForExpectations(timeout: timeout, handler: nil)

    }
    
    
}
