//
//  LensDetailCell.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

final class LensDetailCell: UICollectionViewCell, NibInitializable, ReusableCell {

	@IBOutlet weak private var nameLabel: UILabel!
	@IBOutlet weak private var imageView: UIImageView!
	@IBOutlet weak private var categoryLabel: UILabel!
	@IBOutlet weak private var favoriteButton: UIButton!
	@IBOutlet weak private var questionsTextView: UITextView!

	func render(_ lens: Lens) {
		nameLabel.text = lens.title
		imageView.image = #imageLiteral(resourceName: lens.imageName)

		favoriteButton.setImage(lens.isFavorite ? #imageLiteral(resourceName: "StarFilledIcon") : #imageLiteral(resourceName: "StarIcon"), for: .normal)

		let formattedQuestions = lens.questions
			.map { "- " + $0 }
			.joined(separator: "\n\n")
		questionsTextView.textContainerInset.bottom = 16
		
		questionsTextView.text = formattedQuestions
	}
}
