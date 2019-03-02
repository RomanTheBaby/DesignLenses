//
//  NSMutableAttributedString+Extension.swift
//  DesignLenses
//
//  Created by Baby on 3/2/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
	@discardableResult func bold(_ text: String,
								 colored: UIColor = .black,
								 fontSize: CGFloat = 16,
								 isUnderlined: Bool = false) -> NSMutableAttributedString {
		let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: "HelveticaNeue-Bold", size: fontSize)!,
													.foregroundColor: colored,
													.underlineStyle: isUnderlined ? 1 : 0]
		let boldString = NSMutableAttributedString(string:text, attributes: attrs)
		append(boldString)

		return self
	}

	@discardableResult func normal(_ text: String,
								   colored: UIColor = .black,
								   fontSize: CGFloat = 14,
								   url: URL? = nil,
								   isUnderlined: Bool = false) -> NSMutableAttributedString {
		var attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: "HelveticaNeue", size: fontSize)!,
													.foregroundColor: colored,
													.underlineStyle: isUnderlined ? 1 : 0]

		if let link = url {
			attrs[.link] = link
		}

		let normal = NSMutableAttributedString(string:text, attributes: attrs)
		append(normal)

		return self
	}
}
