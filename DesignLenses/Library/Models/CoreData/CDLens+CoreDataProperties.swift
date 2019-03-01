//
//  CDLens+CoreDataProperties.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//
//

import CoreData
import Foundation

extension CDLens {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLens> {
        return NSFetchRequest<CDLens>(entityName: "Lens")
    }

    @NSManaged public var title: String
    @NSManaged public var prompt: String
    @NSManaged public var questions: [String]
	@NSManaged public var identifier: Int16

}

extension CDLens {
	var asDomain: Lens {
		return Lens(id: identifier, title: title,
					prompt: prompt, imageName: "",
					questions: questions, isFavorite: false,
					quote: nil, quoteAuthor: nil)
	}
}
