//
//  LensesListViewController.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

final class LensesListViewController: UIViewController, StoryboardInstantiatable {

	@IBOutlet weak private var collectionView: UICollectionView!

	override func viewDidLoad() {
        super.viewDidLoad()

		prepareCollectionLayout()
		prepareNavigationControls()
    }

	private func prepareNavigationControls() {
		let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "FilterIcon"), style: .plain,
										   target: nil, action: nil)
		filterButton.tintColor = .black

		navigationItem.rightBarButtonItem = filterButton
	}

	private func prepareCollectionLayout() {
		collectionView.contentInset = UIEdgeInsets(top: Constants.Offset, left: Constants.Offset,
												   bottom: Constants.Offset, right: Constants.Offset)

		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = Constants.LensesInheritemSpacing

		let width = collectionView.frame.width - (Constants.Offset * 2)
		layout.itemSize = CGSize(width: width, height: width)

		collectionView.collectionViewLayout = layout

		collectionView.register(cell: LenseCell.self)
	}

}

extension LensesListViewController {
	struct Constants {
		static let Offset: CGFloat = 16.0
		static let LensesInheritemSpacing: CGFloat = 32.0
	}
}

extension LensesListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withType: LenseCell.self, forItemAt: indexPath)
		return cell
	}
}
