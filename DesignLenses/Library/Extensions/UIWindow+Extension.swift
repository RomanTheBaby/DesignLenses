//
//  UIWindow+Extension.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

extension UIWindow {
	func animateTransition(
		toRoot rootViewController: UIViewController,
		duration: TimeInterval = 0.25,
		options: AnimationOptions = .transitionCrossDissolve) {
		UIView.transition(
			with: self,
			duration: duration,
			options: options,
			animations: {
				self.rootViewController = rootViewController
				self.makeKeyAndVisible()
		}, completion: nil)
	}
}
