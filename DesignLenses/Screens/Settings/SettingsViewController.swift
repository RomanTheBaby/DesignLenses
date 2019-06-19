//
//  SettingsViewController.swift
//  DesignLenses
//
//  Created by Baby on 3/2/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit
import MessageUI

final class SettingsViewController: UIViewController, StoryboardInstantiatable {

	@IBOutlet weak private var tableView: UITableView!

	fileprivate enum ItemType: CaseIterable {
		case privacyPolicy
		case credits
		case contact
		case review
	}

	override func viewDidLoad() {
        super.viewDidLoad()

		title = "Settings"
		prepareTableViews()
		prepareNavigationControls()
    }

	private func prepareTableViews() {
		tableView.tableFooterView = UIView()
		tableView.register(cell: SettingCell.self)
	}

	private func prepareNavigationControls() {
		let settingsItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackArrow"), style: .plain,
										   target: self, action: #selector(popController))
		settingsItem.tintColor = .black

		navigationItem.leftBarButtonItem = settingsItem
	}

	@objc private func popController() {
		navigationController?.popViewController(animated: true)
	}

}

extension SettingsViewController.ItemType {
	var title: String {
		switch self {
		case .privacyPolicy:
			return "Privacy Policy"
		case .credits:
			return "Credits"
		case .contact:
			return "Contact me"
		case .review:
			return "Leave a review"
		}
	}
}

// MARK: - Action Handlers

extension SettingsViewController {
	private func action(for item: ItemType) {
		switch item {
		case .privacyPolicy:
			showPrivacyPolicy()
		case .credits:
			showCredits()
		case .contact:
			showMailComposer()
		case .review:
			redirectToReview()
		}
	}

	private func showCredits() {
		let infoController = InfoViewController.instantiateFromStoryboard()
		present(infoController, animated: true, completion: nil)
		infoController.setContentType(.credits)
	}

	private func showPrivacyPolicy() {
		let infoController = InfoViewController.instantiateFromStoryboard()
		present(infoController, animated: true, completion: nil)
		infoController.setContentType(.privacyPolicy)
	}

	private func redirectToReview() {
		guard let writeReviewURL = URL(string: "https://itunes.apple.com/app/id1392046530?action=write-review")
			else { return }
		UIApplication.shared.open(writeReviewURL,
								  options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]),
								  completionHandler: nil)
	}

	private func showMailComposer() {
		if MFMailComposeViewController.canSendMail() {
			let composeVC = MFMailComposeViewController()
			composeVC.mailComposeDelegate = self

			composeVC.setToRecipients(["appsofrom@gmail.com"])
			composeVC.setSubject("Game-Design Lenses app")
			composeVC.setMessageBody("My letter is about: ", isHTML: false)

			self.present(composeVC, animated: true, completion: nil)
		} else {
			showAlert(message: "This device cannot send mail :(")
		}
	}
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ItemType.allCases.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withType: SettingCell.self, forRowAt: indexPath)
		cell.render(title: ItemType.allCases[indexPath.row].title)
		return cell
	}
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		action(for: ItemType.allCases[indexPath.row])
	}
}


// MARK: - MFMailComposeViewControllerDelegate

extension SettingsViewController: MFMailComposeViewControllerDelegate {
	func mailComposeController(_ controller: MFMailComposeViewController,
							   didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true, completion: nil)
	}
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
