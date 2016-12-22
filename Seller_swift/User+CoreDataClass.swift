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

}

///CoreData操作
let EntityName = "User"
let context = getContext()

// 获取Context
func getContext () -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
}

//增
func addUserCoreData()
{
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

func deleteUserCoreData(username: String)
{
    let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: EntityName)
    let condition = "username='\(username)'"
    let predicate = NSPredicate(format: condition, "")
    request.predicate = predicate
    do{
        //查询满足条件的联系人
        let resultsList = try context.fetch(request) as! [User] as NSArray
        if resultsList.count != 0 {//若结果为多条，则只删除第一条，可根据你的需要做改动
            context.delete(resultsList[0] as! NSManagedObject)
            try context.save()
            print("delete success ~ ~")
        }else{
            print("删除失败！ 没有符合条件的联系人！")
        }
    }catch{
        print("delete fail !")
    }
}

func selectDataFromUserCoreData() -> NSArray
{
    var dataSource = NSArray()
    let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
    let entity:NSEntityDescription? = NSEntityDescription.entity(forEntityName: EntityName, in: context)
    request.entity = entity
    do{
        dataSource = try context.fetch(request) as! [User] as NSArray
        print("数据读取成功 ~ ~")
    }catch{
        print("get_coredata_fail!")
    }

    return dataSource
}

//查询所有数据并输出
func printAllDataWithUserCoreData()
{
    let array = selectDataFromUserCoreData()
    for item in array {
        let user = item as! User
        print("username=",user.username!,"password=",user.password!)
    }
}

func deleteAllUserCoreData() {
    
    let array = selectDataFromUserCoreData()
    for item in array {
        let user = item as! User
        deleteUserCoreData(username: user.username!)
        print("username=",user.username ?? "","password=",user.password ?? "")
    }
}

