//
//  AppCoordinator.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

final class AppCoordinator {
	private var window: UIWindow?

	private lazy var rootViewController: UINavigationController = {
		let rootController = LensesListViewController()
		let navigationController = UINavigationController(rootViewController: rootController)
		navigationController.navigationBar.barTintColor = .white
		navigationController.navigationBar.isTranslucent = false
		navigationController.navigationBar.shadowImage = UIImage()

		return navigationController
	}()

	init() {}

	func start() {
		let window = UIWindow()
		window.animateTransition(toRoot: rootViewController, duration: 0.0)
		self.window = window
	}
}
