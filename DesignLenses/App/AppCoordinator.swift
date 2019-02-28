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
		let rootController = UIViewController()
//		let tabBarController = MainTabBarController.instantiateFromStoryboard()
		let navigationController = UINavigationController(rootViewController: rootController)
		navigationController.setNavigationBarHidden(true, animated: false)
		return navigationController
	}()

	init() {}

	func start() {
		let window = UIWindow()
		window.animateTransition(toRoot: rootViewController, duration: 0.0)
		self.window = window

	}
}
