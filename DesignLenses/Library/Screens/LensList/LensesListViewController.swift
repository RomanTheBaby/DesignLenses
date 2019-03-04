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
		safelyLoadLenses()
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
		let height = (width * LensCell.ImageAspectRation) + LensCell.BottomContainerHeight
		layout.itemSize = CGSize(width: width, height: height)

		collectionView.collectionViewLayout = layout
		collectionView.register(cell: LensCell.self)
	}

	private func safelyLoadLenses(with filter: LensService.FilterType = .none) {
		guard lensService.willChange(with: filter) else { return }
		fetchLenses(filterType: filter)
	}

	private func fetchLenses(filterType: LensService.FilterType) {
		title = filterType.description

		lenses = lensService.filter(by: filterType)
		collectionView.reloadData()

		guard !lenses.isEmpty else { return }

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
		let filter = lensService.currentFilter
		let actionNone = UIAlertAction( title: "None \(filter == .none ? " ✔︎" : "  ")", style: .default) { [weak self] _ in
			self?.safelyLoadLenses()
		}

		let actionName = UIAlertAction(title: "Name \(filter == .name ? " ✔︎" : "  ")", style: .default) { [weak self] _ in
			self?.safelyLoadLenses(with: .name)
		}

		let actionFavorite = UIAlertAction(title: "Favorite \(filter == .favorite ? " ✔︎" : "  ")", style: .default) { [weak self] _ in
			self?.safelyLoadLenses(with: .favorite)
		}

		let actionDesigner = UIAlertAction(title: "Category: Designer \(filter == .category(.designer) ? " ✔︎" : "  ")", style: .default) { [weak self] _ in
			self?.safelyLoadLenses(with: .category(.designer))
		}

		let actionPlayer = UIAlertAction( title: "Category: Player \(filter == .category(.player) ? " ✔︎" : "  ")", style: .default) { [weak self] _ in
			self?.safelyLoadLenses(with: .category(.player))
		}

		let actionExperience = UIAlertAction(title: "Category: Experience \(filter == .category(.experience) ? " ✔︎" : "  ")", style: .default) { [weak self] _ in
			self?.safelyLoadLenses(with: .category(.experience))
		}

		let actionProcess = UIAlertAction(title: "Category: Process \(filter == .category(.process) ? " ✔︎" : "  ")", style: .default) { [weak self] _ in
			self?.safelyLoadLenses(with: .category(.process))
		}

		let actionGame = UIAlertAction(title: "Category: Game \(filter == .category(.game) ? " ✔︎" : "  ")", style: .default) { [weak self] _ in
			self?.safelyLoadLenses(with: .category(.game))
		}

		alertController.addAction(actionNone)
		alertController.addAction(actionName)
		alertController.addAction(actionFavorite)
		alertController.addAction(actionDesigner)
		alertController.addAction(actionPlayer)
		alertController.addAction(actionExperience)
		alertController.addAction(actionProcess)
		alertController.addAction(actionGame)

		alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		present(alertController, animated: true, completion: nil)
	}

	@objc private func lensFavoriteButtonTap(_ button: LensLikeButton) {
		guard var lens = button.lens else { return }
		lens.isFavorite = !lens.isFavorite
		lensService.update(lens: lens)
		fetchLenses(filterType: lensService.currentFilter)
	}
}

// MARK: - UICollectionViewDataSource

extension LensesListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return lenses.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withType: LensCell.self, forItemAt: indexPath)
		cell.favoriteButton.addTarget(self, action: #selector(lensFavoriteButtonTap(_:)), for: .touchUpInside)
		cell.render(lenses[indexPath.row])
		return cell
	}
}

// MARK: - UICollectionViewDelegate

extension LensesListViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		presentDetails(for: lenses, from: indexPath.row)
	}
}
