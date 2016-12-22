//
//  NetworkRequest.swift
//  Seller_swift
//
//  Created by fanpeng on 16/12/14.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let NetworkRequestShareInstance = NetworkRequest()



class NetworkRequest {
    
    class var sharedInstance : NetworkRequest {
        return NetworkRequestShareInstance
    }
    
    func userJson() -> JSON {
        if userDefault.object(forKey: "userInfo") != nil {
            let userInfo = userDefault.object(forKey: "userInfo")
            let userJson = JSON(userInfo!)
            return userJson
        }
        return ""
    }
    
    func token() -> String {
        return  userJson()["token"].stringValue
    }
    
    func userId() -> Int {
        return  userJson()["userId"].intValue
    }
    
    func deviceId() -> String {
        let uuid = UIDevice.current.identifierForVendor 
        return uuid!.uuidString
    }
    
    func appVersion() -> String {
        
        let infoDictionary = Bundle.main.infoDictionary
        let majorVersion = infoDictionary?["CFBundleShortVersionString"]
        let appversion = majorVersion as! String
        return appversion
        
    }
    
    func osVersion() -> String {
        let iosversion = UIDevice.current.systemVersion  //ios 版本
        return iosversion
    }
    
    func deviceType() -> String {
        let model = UIDevice.current.model   //设备型号
        return model
    }
    
    func brandName() -> String {
        let systemName = UIDevice.current.systemName   //设备名称
        return systemName
    }
    
}

extension NetworkRequest {
    //MARK: - POST 请求
@discardableResult  func postRequest(_ urlString : String, params : Parameters, success : @escaping (_ response : RequestModel)->(), failture : @escaping (_ error : Error)->()) -> Alamofire.Request {
        
        //data的参数需要转换问json字符串传到后台
        let data = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        let dataStr = NSString(data: data, encoding:String.Encoding.utf8.rawValue)!
        
        let parameters: Parameters = [
            "deviceId":deviceId(),
            "appVersion":appVersion(),
            "osVersion":osVersion(),
            "deviceType":deviceType(),
            "brandName":brandName(),
            "token": token(),
            "userId": userId(),
            "data": dataStr
        ]
    
        DLog(message: parameters)

       let request = Alamofire.request("http://testapi.o2o.zhaioto.com/staff/v1/\(urlString)", method: HTTPMethod.post, parameters: parameters).responseJSON { (response) in
            DLog(message: "URL:http://testapi.o2o.zhaioto.com/staff/v1/\(urlString)")
            DLog(message: response)
            switch response.result{
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let requestModel = RequestModel(json)
                    success(requestModel)
                }
            case .failure(let error):
                failture(error)
                DLog(message: "error:\(error)")
            }
        }
        
        return request
    }
    
    //MARK: - GET 请求
    //    let tools : NetworkRequest.shareInstance!
    func getRequest(urlString: String, params : Parameters, success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()) {
        
        //使用Alamofire进行网络请求时，调用该方法的参数都是通过getRequest(urlString， params, success :, failture :）传入的，而success传入的其实是一个接受           [String : AnyObject]类型 返回void类型的函数
        Alamofire.request(urlString, method: .get, parameters: params)
            .responseJSON { (response) in/*这里使用了闭包*/
                //当请求后response是我们自定义的，这个变量用于接受服务器响应的信息
                //使用switch判断请求是否成功，也就是response的result
                switch response.result {
                case .success(let value):
                    //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
                    //                    if let value = response.result.value as? [String: AnyObject] {
                    success(value as! [String : AnyObject])
           
                    
                case .failure(let error):
                    failture(error)
                    print("error:\(error)")
                }
        }
        
    }

    
//    MARK: - 照片上传
//    /
//    / - Parameters:
//    /   - urlString: 服务器地址
//    /   - params: ["flag":"","userId":""] - flag,userId 为必传参数
//    /        flag - 666 信息上传多张  －999 服务单上传  －000 头像上传
//    /   - data: image转换成Data
//    /   - name: fileName
//    /   - success:
//    /   - failture:
    func upLoadImageRequest(urlString : String, params:[String:String], data: [Data], name: [String],success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //666多张图片上传
                let flag = params["flag"]
                let userId = params["userId"]
                
                multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!, withName: "flag")
                multipartFormData.append( (userId?.data(using: String.Encoding.utf8)!)!, withName: "userId")
                
                for i in 0..<data.count {
                    multipartFormData.append(data[i], withName: "appPhoto", fileName: name[i], mimeType: "image/png")
                }
        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                        }
                    }
                case .failure(let encodingError):
                    failture(encodingError)
                }
        }
        )
    }
}
