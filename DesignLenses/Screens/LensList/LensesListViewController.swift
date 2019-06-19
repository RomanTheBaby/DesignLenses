//
//  LensesListViewController.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

final class LensesListViewController: UIViewController {

	private weak var collectionView: UICollectionView!

	private let lensService: LensService
	private lazy var lenses: [Lens] = []

	init(lensService: LensService = LensService()) {
		self.lensService = lensService
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

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

	private func prepareCollectionLayout() {

		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = Constants.LensesInheritemSpacing

		let itemWidth = UIScreen.main.bounds.width - (Constants.Offset * 2)
		let itemHeight = (itemWidth * LensCell.ImageAspectRation) + LensCell.BottomContainerHeight
		layout.itemSize = CGSize(width: itemWidth, height: itemHeight)

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = .white
		collectionView.translatesAutoresizingMaskIntoConstraints = false

		collectionView.dataSource = self
		collectionView.delegate = self

		view.addSubview(collectionView)

		constraint(edgesOf: collectionView, toView: view)

		collectionView.register(cell: LensCell.self)

		self.collectionView = collectionView
	}

	private func safelyLoadLenses(with filter: LensService.FilterType = .none) {
		guard lensService.willChange(with: filter) else { return }
		fetchLenses(filterType: filter)
	}

	private func fetchLenses(filterType: LensService.FilterType, scrollToTop: Bool = true) {
		title = filterType.description

		reloadLenses()

		guard !lenses.isEmpty, scrollToTop else { return }
		collectionView.scrollToItem(at: .init(row: 0, section: 0), at: .top, animated: true)
	}

	private func reloadLenses(filterType: LensService.FilterType? = nil) {
		lenses = lensService.filter(by: filterType ?? lensService.currentFilter)
		collectionView.reloadData()
	}

	private func presentDetails(for lenses: [Lens], from index: Int) {
		let detailController = LensDetailViewController.instantiateFromStoryboard()
		detailController.lensService = lensService
		detailController.setLensesQueue(lenses, startIndex: index)

		detailController.cardsUpdated = { [weak self] in
			self?.reloadLenses()
		}

		present(detailController, animated: true, completion: nil)
	}

	@objc private func showSettings() {
		let settingsController = SettingsViewController.instantiateFromStoryboard()

		navigationController?.pushViewController(settingsController, animated: true)
	}
}

extension LensesListViewController {
	struct Constants {
		static let Offset: CGFloat = 16.0
		static let LensesInheritemSpacing: CGFloat = 32.0
	}
}

extension LensesListViewController {

	// MARK: - Do something about this filter
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
		fetchLenses(filterType: lensService.currentFilter, scrollToTop: false)
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
