//
//  LensDetailCell.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

final class LensDetailCell: UICollectionViewCell, NibInitializable, ReusableCell {

	@IBOutlet weak private var scrollView: UIScrollView!

	@IBOutlet weak private var nameLabel: UILabel!
	@IBOutlet weak private var imageView: UIImageView!
	@IBOutlet weak private var categoryLabel: UILabel!
	@IBOutlet weak private(set) var favoriteButton: LensLikeButton!
	@IBOutlet weak private var questionsTextView: UITextView!

	@IBOutlet weak private var promptContainer: UIView!
	@IBOutlet weak private var quoteLabel: UILabel!
	@IBOutlet weak private var quoteAuthorLabel: UILabel!
	@IBOutlet weak private var promptTextView: UITextView!


	override func awakeFromNib() {
		super.awakeFromNib()

		promptContainer.layer.borderColor = UIColor.orange.cgColor
		promptContainer.layer.borderWidth = 2.0
		promptContainer.layer.cornerRadius = 8.0
	}

	func render(_ lens: Lens) {
		favoriteButton.lens = lens
		categoryLabel.text = lens.categories.map { $0.description }.joined(separator: ", ")

		nameLabel.text = "The Lens of " + lens.title
		imageView.image = #imageLiteral(resourceName: lens.imageName)

		favoriteButton.setImage(lens.isFavorite ? #imageLiteral(resourceName: "StarFilledIcon") : #imageLiteral(resourceName: "StarIcon"), for: .normal)
		
		questionsTextView.text = lens.formattedQuestions
		promptTextView.text = lens.prompt

		quoteLabel.text = lens.quote
		quoteLabel.isHidden = lens.quote == nil

		quoteAuthorLabel.text = lens.quoteAuthor
		quoteAuthorLabel.isHidden = lens.quoteAuthor == nil

		promptContainer.layoutSubviews()
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		quoteLabel.isHidden = false
		quoteAuthorLabel.isHidden = false
	}
}

extension Lens {
	fileprivate var formattedQuestions: String {
		return questions
			.map { "- " + $0 }
			.joined(separator: "\n\n")
	}
}
