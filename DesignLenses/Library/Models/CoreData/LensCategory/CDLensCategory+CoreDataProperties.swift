//
//  CDLensCategory+CoreDataProperties.swift
//  DesignLenses
//
//  Created by Baby on 3/2/19.
//  Copyright © 2019 baby. All rights reserved.
//
//

import Foundation
import CoreData


extension CDLensCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLensCategory> {
        return NSFetchRequest<CDLensCategory>(entityName: "LensCategory")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String

}
