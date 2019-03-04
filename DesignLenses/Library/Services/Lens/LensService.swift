//
//  LensService.swift
//  DesignLenses
//
//  Created by Baby on 3/2/19.
//  Copyright © 2019 baby. All rights reserved.
//

import Foundation

final class LensService {

	enum FilterType: Equatable {
		case none
		case name
		case category(LensCategory)

		var description: String {
			switch self {
			case .none:
				return "Lenses"
			case .name:
				return "Name Sorted Lenses"
			case .category(let category):
				return category.description
			}
		}
	}

	lazy var fetchedLenses = fileData()
	private(set) lazy var currentFilter: FilterType = .name

	func willChange(with filterType: FilterType) -> Bool {
		return currentFilter != filterType
	}

	func filter(by filterType: FilterType) -> [Lens] {

		currentFilter = filterType

		switch filterType {
		case .none:
			return fetchedLenses
		case .name:
			return fetchedLenses.sorted(by: { $0.title < $1.title })
		case .category(let category):
			return fetchedLenses.filter { $0.categories.contains(category) }
		}
	}

}

private func fileData() -> [Lens] {
	guard
		let url = Bundle.main.url(forResource: "Lens", withExtension: "json"),
		let data = try? Data(contentsOf: url),
		let fixture = try? JSONDecoder().decode(LensesFixture.self, from: data)
		else {
			fatalError("Could not load fixture Lens.json from test bundle.")
	}

	print(fixture.lenses.count)
	return fixture.lenses
}

private struct LensesFixture: Decodable {
	let lenses: [Lens]
}
