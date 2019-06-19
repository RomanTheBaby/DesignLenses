
//
//  InfoViewController.swift
//  DesignLenses
//
//  Created by Baby on 3/2/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

final class InfoViewController: UIViewController, StoryboardInstantiatable {

	enum InfoType {
		case credits
		case privacyPolicy
	}

	@IBOutlet weak private var textView: UITextView!

	func setContentType(_ type: InfoType) {
		switch type {
		case .credits:
			textView.attributedText = InfoService().makeCredits()
		case .privacyPolicy:
			textView.attributedText = InfoService().makePrivacyPolicy()
		}
	}

	@IBAction private func actionClose(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
}
