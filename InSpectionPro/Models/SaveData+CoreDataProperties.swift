//
//  SaveData+CoreDataProperties.swift
//  
//
//  Created by praveen dole on 3/23/18.
//
//

import Foundation
import CoreData


extension SaveData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaveData> {
        return NSFetchRequest<SaveData>(entityName: "SaveData")
    }

    @NSManaged public var appId: String?
    @NSManaged public var lineId: String?
    @NSManaged public var name: String?
    @NSManaged public var unitId: String?

}
