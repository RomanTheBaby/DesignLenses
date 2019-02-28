//
//  StoryboardInstantiatable.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

protocol StoryboardInstantiatable {
	static var storyboard: UIStoryboard { get }
	static func instantiateFromStoryboard() -> Self
}

extension StoryboardInstantiatable where Self: UIViewController {

	static var storyboard: UIStoryboard {
		let bundle = Bundle(for: Self.self)
		let storyboardName = String(describing: Self.self)
		return UIStoryboard(name: storyboardName, bundle: bundle)
	}

	static func instantiateFromStoryboard() -> Self {
		guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
			fatalError("Could not instantiate view controller from storyboard.")
		}

		return viewController
	}
}
