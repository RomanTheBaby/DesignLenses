//
//  LensService.swift
//  DesignLenses
//
//  Created by Baby on 3/2/19.
//  Copyright © 2019 baby. All rights reserved.
//

import Foundation

final class LensService {
	init () {
	}

	func fetchStoredLenses() -> [Lens] {
		return fileData()
	}

	// TODO: - rename
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
}

private struct LensesFixture: Decodable {
	let lenses: [Lens]
}
