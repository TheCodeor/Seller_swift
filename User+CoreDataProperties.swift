//
//  User+CoreDataProperties.swift
//  Seller_swift
//
//  Created by fanpeng on 16/12/21.
//  Copyright © 2016年 fanpeng. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?

}
