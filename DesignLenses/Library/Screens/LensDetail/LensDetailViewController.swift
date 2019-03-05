//
//  LensDetailViewController.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

final class LensDetailViewController: UIViewController, StoryboardInstantiatable {

	@IBOutlet weak private var collectionView: UICollectionView!

	private var lenses: [Lens] = []
	private var startIndex: Int = 0
	var lensService: LensService!

	var cardsUpdated: (() -> Void)?

	override var prefersStatusBarHidden: Bool {
		return true
	}

	// MARK: - Parent Methods

	override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.isHidden = true
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		prepareCollectionLayout()

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.13) {
			self.collectionView.scrollToItem(at: IndexPath(row: self.startIndex, section: 0),
											 at: .centeredHorizontally, animated: false)
			self.collectionView.isHidden = false
		}
	}

	// MARK: - Public Methods

	func setLensesQueue(_ queue: [Lens], startIndex: Int) {
		lenses = queue
		self.startIndex = startIndex
	}

	// MARK: - Private Methods

	private func prepareCollectionLayout() {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0

		layout.itemSize = view.frame.size

		collectionView.collectionViewLayout = layout
		collectionView.register(cell: LensDetailCell.self)
		collectionView.isPagingEnabled = true
	}

	@objc private func lensFavoriteButtonTap(_ button: LensLikeButton) {
		guard var lens = button.lens else { return }
		lens.isFavorite = !lens.isFavorite
		lensService.update(lens: lens)

		cardsUpdated?()

		lenses = lensService.filter(by: lensService.currentFilter)
		collectionView.reloadData()
	}

	@IBAction private func actionClose(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
}

// MARK: - UICollectionViewDataSource

extension LensDetailViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return lenses.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withType: LensDetailCell.self, forItemAt: indexPath)
		cell.favoriteButton.addTarget(self, action: #selector(lensFavoriteButtonTap(_:)), for: .touchUpInside)
		cell.render(lenses[indexPath.row])
		return cell
	}
}
