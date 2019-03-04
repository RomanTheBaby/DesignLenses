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
										   target: self, action: #selector(showFilterOptions))
		filterButton.tintColor = .black

		navigationItem.rightBarButtonItem = filterButton

		let settingsItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Settings"), style: .plain,
										   target: self, action: #selector(showSettings))
		settingsItem.tintColor = .black

		navigationItem.leftBarButtonItem = settingsItem
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

	private func loadCards(with filter: LensService.FilterType = .none) {
		lenses = lensService.filter(by: filter)
		collectionView.reloadData()

		collectionView.scrollToItem(at: .init(row: 0, section: 0), at: .top, animated: true)
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

extension LensesListViewController {
	@objc private func showFilterOptions() {
		let alertController = UIAlertController(title: "Choose filter type:", message: nil, preferredStyle: .actionSheet)
		let actionNone = UIAlertAction(title: "None", style: .default) { [weak self] _ in
			self?.loadCards()
		}

		let actionName = UIAlertAction(title: "Name", style: .default) { [weak self] _ in
			self?.loadCards(with: .name)
		}

		let actionDesigner = UIAlertAction(title: "Category: Designer", style: .default) { [weak self] _ in
			self?.loadCards(with: .category(.designer))
		}

		let actionPlayer = UIAlertAction(title: "Category: Player", style: .default) { [weak self] _ in
			self?.loadCards(with: .category(.player))
		}

		let actionExperience = UIAlertAction(title: "Category: Experience", style: .default) { [weak self] _ in
			self?.loadCards(with: .category(.experience))
		}

		let actionProcess = UIAlertAction(title: "Category: Process", style: .default) { [weak self] _ in
			self?.loadCards(with: .category(.process))
		}

		let actionGame = UIAlertAction(title: "Category: Game", style: .default) { [weak self] _ in
			self?.loadCards(with: .category(.game))
		}

		alertController.addAction(actionNone)
		alertController.addAction(actionName)
		alertController.addAction(actionDesigner)
		alertController.addAction(actionPlayer)
		alertController.addAction(actionExperience)
		alertController.addAction(actionProcess)
		alertController.addAction(actionGame)

		alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		present(alertController, animated: true, completion: nil)
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
