//
//  User+CoreDataClass.swift
//  Seller_swift
//
//  Created by fanpeng on 16/12/21.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(User)
public class User: NSManagedObject {
    
    ///CoreData操作
    let EntityName = "User"

    // 获取Context
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    //增
    func addCoreData()
    {
        let context = getContext()
        let entity = NSEntityDescription.insertNewObject(forEntityName: EntityName, into: context) as! User
        entity.username = "周杰伦"
        entity.password = "123456789952"
        do
        {
            try context.save()
            print("添加成功 ~ ~ ")
        }catch
        {
            print("添加失败！！")
        }
    }
//    
//    func selectDataFromCoreData() -> NSArray
//    {
//        var dataSource = NSArray()
//        let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
//        let entity:NSEntityDescription? = NSEntityDescription.entity(forEntityName: EntityName, in: appDelegate.managedObjectContext)
//        request.entity = entity
//        do{
//            dataSource = try appDelegate.managedObjectContext.fetch(request) as! [User] as NSArray
//            print("数据读取成功 ~ ~")
//        }catch{
//            print("get_coredata_fail!")
//        }
//        
//        return dataSource
//    }
//    
//    //查询所有数据并输出
//    func printAllDataWithCoreData()
//    {
//        let array = getDataFromCoreData()
//        for item in array {
//            let user = item as! User
//            print("name=",user.name,"tel=",user.tel,"email=",user.email,"address=",user.address)
//        }
//    }

    

}
