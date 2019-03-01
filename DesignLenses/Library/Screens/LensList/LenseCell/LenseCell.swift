//
//  LenseCell.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

final class LenseCell: UICollectionViewCell, NibInitializable, ReusableCell {

	static let ImageAspectRation: CGFloat = 9/16
	static let BottomContainerHeight: CGFloat = 50

	@IBOutlet weak private var nameLabel: UILabel!
	@IBOutlet weak private var imageView: UIImageView!
	@IBOutlet weak private var favoriteButton: UIButton!
	@IBOutlet weak private var contentContainerView: UIView!

	private var hasShadow = false
	override func layoutSubviews() {
		super.layoutSubviews()

		contentContainerView.roundCornersBy(16)

		guard hasShadow == false else { return }
		addShadow()
		hasShadow = true
	}

	func render(_ lens: Lens) {
		nameLabel.text = lens.title

		imageView.image = #imageLiteral(resourceName: lens.imageName)
		favoriteButton.setImage(lens.isFavorite ? #imageLiteral(resourceName: "StarFilledIcon") : #imageLiteral(resourceName: "StarIcon"), for: .normal)
	}
}
