//
//  UIViewController+Extension.swift
//  DesignLenses
//
//  Created by Baby on 3/2/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

extension UIViewController {
	func showErrorAlert(title: String = "Ooops", error: Error, cancelTitle: String = "OK") {
		showAlert(title: title, message: error.localizedDescription, cancelTitle: cancelTitle)
	}

	func showAlert(title: String = "Ooops", message: String, cancelTitle: String = "OK") {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
		alertController.addAction(cancelAction)
		
		present(alertController, animated: true, completion: nil)
	}

	func constraint(edgesOf childView: UIView, toView view: UIView, with insets: UIEdgeInsets = .zero) {
		NSLayoutConstraint.activate(childView.constraints(toEdgesOf: view, insets: insets))
	}
}
