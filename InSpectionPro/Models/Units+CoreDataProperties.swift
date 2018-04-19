//
//  Units+CoreDataProperties.swift
//  
//
//  Created by praveen dole on 3/23/18.
//
//

import Foundation
import CoreData


extension Units {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Units> {
        return NSFetchRequest<Units>(entityName: "Units")
    }

    @NSManaged public var appId: String?
    @NSManaged public var lineId: String?
    @NSManaged public var name: String?
    @NSManaged public var unitId: String?

}
