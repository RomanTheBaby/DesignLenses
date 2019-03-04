//
//  CDLens+CoreDataClass.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//
//

import CoreData
import Foundation

@objc(CDLens)
public class CDLens: NSManagedObject {

	func update(with lens: Lens) {
		self.identifier = lens.id
		self.imageName = lens.imageName
		self.isFavorite = lens.isFavorite
		self.prompt = lens.prompt
		self.questions = lens.questions
		self.quote = lens.quote
		self.quoteAuthor = lens.quoteAuthor
		self.title = lens.title
		self.categoriesIdentifiers = lens.categoriesIds
	}

}
