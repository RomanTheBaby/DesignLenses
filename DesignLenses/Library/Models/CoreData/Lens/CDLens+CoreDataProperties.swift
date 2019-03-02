//
//  CDLens+CoreDataProperties.swift
//  DesignLenses
//
//  Created by Baby on 3/2/19.
//  Copyright © 2019 baby. All rights reserved.
//
//

import Foundation
import CoreData


extension CDLens {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLens> {
        return NSFetchRequest<CDLens>(entityName: "Lens")
    }

    @NSManaged public var identifier: Int16
    @NSManaged public var imageName: String
    @NSManaged public var isFavorite: Bool
    @NSManaged public var prompt: String
    @NSManaged public var questions: [String]
    @NSManaged public var quote: String?
    @NSManaged public var quoteAuthor: String?
    @NSManaged public var title: String
    @NSManaged public var category: CDLensCategory

}

extension CDLens {
	var asDomain: Lens {
		return Lens(id: identifier, title: title,
					prompt: prompt, imageName: imageName,
					questions: questions, isFavorite: isFavorite,
					quote: quote, quoteAuthor: quoteAuthor)
	}
}
