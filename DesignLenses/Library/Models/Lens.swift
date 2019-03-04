//
//  Lens.swift
//  DesignLenses
//
//  Created by Baby on 3/4/19.
//  Copyright © 2019 baby. All rights reserved.
//

import Foundation

struct Lens: Decodable {
	let id: Int16
	let title: String
	let prompt: String
	let imageName: String
	let questions: [String]
	let isFavorite: Bool

	let quote: String?
	let quoteAuthor: String?

	let categoryId: Int16
}

extension Lens {
	var category: LensCategory {
		return LensCategory(rawValue: Int(categoryId))!
	}
}
