//
//  Sqlite_Sequence+CoreDataProperties.swift
//  
//
//  Created by praveen dole on 3/23/18.
//
//

import Foundation
import CoreData


extension Sqlite_Sequence {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sqlite_Sequence> {
        return NSFetchRequest<Sqlite_Sequence>(entityName: "Sqlite_Sequence")
    }

    @NSManaged public var name: String?
    @NSManaged public var seq: String?

}
