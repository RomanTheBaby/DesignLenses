//
//  ReusableCell.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

protocol ReusableCell {
	static var reuseIdentifier: String { get }
}

extension ReusableCell {
	static var reuseIdentifier: String {
		return String(describing: Self.self)
	}
}

extension UITableView {
	func dequeueReusableCell<Cell: ReusableCell>(withType type: Cell.Type, forRowAt indexPath: IndexPath) -> Cell {
		guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
			fatalError("Could not dequeue reusable cell with \(Cell.reuseIdentifier) reuse identifier.")
		}

		return cell
	}

	func register<C: ReusableCell & NibInitializable>(cell: C.Type) {
		self.register(C.nib, forCellReuseIdentifier: C.reuseIdentifier)
	}
}

extension UICollectionView {
	func dequeueReusableCell<Cell: ReusableCell>(withType type: Cell.Type, forItemAt indexPath: IndexPath) -> Cell {
		guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
			fatalError("Could not dequeue reusable cell with \(Cell.reuseIdentifier) reuse identifier.")
		}

		return cell
	}

	func register<C: ReusableCell & NibInitializable>(cell: C.Type) {
		self.register(C.nib, forCellWithReuseIdentifier: C.reuseIdentifier)
	}
}
