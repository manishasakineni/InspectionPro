//
//  Lines+CoreDataProperties.swift
//  
//
//  Created by praveen dole on 3/23/18.
//
//

import Foundation
import CoreData


extension Lines {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lines> {
        return NSFetchRequest<Lines>(entityName: "Lines")
    }

    @NSManaged public var appId: String?
    @NSManaged public var lineId: String?
    @NSManaged public var name: String?
    @NSManaged public var frequency: String?
    @NSManaged public var window: Int64
    @NSManaged public var lastExecuted: String?
    @NSManaged public var closed: Bool
    @NSManaged public var status: Bool
    @NSManaged public var isUpdatedServer: Bool 
    @NSManaged public var isFailed: Bool
    @NSManaged public var isUnsaved: Bool

}
