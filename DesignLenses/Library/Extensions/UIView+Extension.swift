//
//  UIView+Extension.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

extension UIView {
	func roundCornersBy(_ radius: CGFloat, addShadow: Bool = false) {
		layer.cornerRadius = radius

		guard addShadow else {
			clipsToBounds = true
			return
		}

		self.addShadow()

		layer.shadowPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners,
										cornerRadii: CGSize(width: radius, height: radius)).cgPath
	}

	func addShadow(
		colored color: UIColor = .black,
		radius: CGFloat = 6.0,
		opacity: Float = 0.4,
		offset: CGSize = CGSize(width: 3.0, height: 5.0)) {
		layer.shadowColor = color.cgColor
		layer.shadowRadius = radius
		layer.shadowOpacity = opacity
		layer.shadowOffset = offset
	}
}

