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

	private let lensService = LensService()
	private lazy var lenses: [Lens] = []

	override func viewDidLoad() {
        super.viewDidLoad()

		title = "Lenses"

		prepareCollectionLayout()
		prepareNavigationControls()
		loadCards()
    }

	private func prepareNavigationControls() {
		let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "FilterIcon"), style: .plain,
										   target: self, action: #selector(scrollToBottom))
		filterButton.tintColor = .black

		navigationItem.rightBarButtonItem = filterButton

		let settingsItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Settings"), style: .plain,
										   target: self, action: #selector(showSettings))
		settingsItem.tintColor = .black

		navigationItem.leftBarButtonItem = settingsItem
	}

	@objc private func scrollToBottom() {
		collectionView.scrollToItem(at: IndexPath(row: 9, section: 0), at: .top, animated: true)
	}

	@objc private func showSettings() {
		let settingsController = SettingsViewController.instantiateFromStoryboard()

		navigationController?.pushViewController(settingsController, animated: true)
	}

	private func prepareCollectionLayout() {
		collectionView.contentInset = UIEdgeInsets(top: Constants.Offset, left: Constants.Offset,
												   bottom: Constants.Offset, right: Constants.Offset)

		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = Constants.LensesInheritemSpacing

		let width = UIScreen.main.bounds.width - (Constants.Offset * 2)
		let height = (width * LenseCell.ImageAspectRation) + LenseCell.BottomContainerHeight
		layout.itemSize = CGSize(width: width, height: height)

		collectionView.collectionViewLayout = layout
		collectionView.register(cell: LenseCell.self)
	}

	private func loadCards() {
		lenses = lensService.fetchStoredLenses()
		collectionView.reloadData()
	}

	private func presentDetails(for lenses: [Lens], from index: Int) {
		let detailController = LensDetailViewController.instantiateFromStoryboard()
		detailController.setLensesQueue(lenses, startIndex: index)

		present(detailController, animated: true, completion: nil)
	}
}

extension LensesListViewController {
	struct Constants {
		static let Offset: CGFloat = 16.0
		static let LensesInheritemSpacing: CGFloat = 32.0
	}
}

// MARK: - UICollectionViewDataSource

extension LensesListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return lenses.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withType: LenseCell.self, forItemAt: indexPath)
		cell.render(lenses[indexPath.row])
		return cell
	}
}

extension LensesListViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		presentDetails(for: lenses, from: indexPath.row)
	}
}
