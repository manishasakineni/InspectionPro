//
//  User+CoreDataProperties.swift
//  
//
//  Created by praveen dole on 3/23/18.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var facility: String?
    @NSManaged public var password: String?
    @NSManaged public var userId: String?

}
