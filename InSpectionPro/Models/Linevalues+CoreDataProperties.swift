//
//  Linevalues+CoreDataProperties.swift
//  
//
//  Created by praveen dole on 3/23/18.
//
//

import Foundation
import CoreData


extension Linevalues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Linevalues> {
        return NSFetchRequest<Linevalues>(entityName: "Linevalues")
    }

    @NSManaged public var appId: String?
    @NSManaged public var id: String?
    @NSManaged public var parentId: String?
    @NSManaged public var name: String?
    @NSManaged public var isInspection: Bool

}
