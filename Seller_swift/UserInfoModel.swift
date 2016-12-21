//
//  UserInfoModel.swift
//  Seller_swift
//
//  Created by fanpeng on 16/12/21.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import UIKit
import CoreData

class UserInfoModel {
    
    // 获取Context
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    // 存储Person
    func storeSeller(name:String, age:String){
        let context = getContext()
        // 定义一个entity，这个entity一定要在xcdatamodeld中做好定义
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let person = NSManagedObject(entity: entity!, insertInto: context)
        
        person.setValue(name, forKey: "username")
        person.setValue(age, forKey: "password")
        
        do {
            try context.save()
            print("saved")
        }catch{
            print(error)
        }
    }
    
    // 获取某一entity的所有数据
    func getSeller(){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            print("numbers of \(searchResults.count)")
            
            for p in (searchResults as! [NSManagedObject]){
                print("name:  \(p.value(forKey: "username")!) password: \(p.value(forKey: "password")!)")
            }
        } catch  {
            print(error)
        }
    }
}
