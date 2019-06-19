//
//  SettingCell.swift
//  DesignLenses
//
//  Created by Baby on 3/2/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

final class SettingCell: UITableViewCell, ReusableCell, NibInitializable {

	@IBOutlet weak private var mainLabel: UILabel!

	func render(title: String) {
		mainLabel.text = title
	}
}
