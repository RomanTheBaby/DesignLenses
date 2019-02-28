//
//  LenseCell.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

final class LenseCell: UICollectionViewCell, NibInitializable, ReusableCell {

	@IBOutlet weak private var contentContainerView: UIView!

	override func layoutSubviews() {
		super.layoutSubviews()

		contentContainerView.roundCornersBy(16, addShadow: true)
	}
}
