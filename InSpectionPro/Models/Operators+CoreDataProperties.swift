//
//  Operators+CoreDataProperties.swift
//  
//
//  Created by praveen dole on 3/23/18.
//
//

import Foundation
import CoreData


extension Operators {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Operators> {
        return NSFetchRequest<Operators>(entityName: "Operators")
    }

    @NSManaged public var name: String?

}
