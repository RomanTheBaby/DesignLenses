//
//  LensService.swift
//  DesignLenses
//
//  Created by Baby on 3/2/19.
//  Copyright © 2019 baby. All rights reserved.
//

import Foundation

final class LensService {

	enum FilterType {
		case none
		case name
		case category(LensCategory)
	}

	lazy var fetchedLenses = fileData()

	func filter(by filterType: FilterType) -> [Lens] {
		switch filterType {
		case .none:
			return fetchedLenses
		case .name:
			return fetchedLenses.sorted(by: { $0.title < $1.title })
		case .category(let category):
			return fetchedLenses.filter { $0.category == category }
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
