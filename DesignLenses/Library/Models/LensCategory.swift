//
//  LensCategory.swift
//  DesignLenses
//
//  Created by Baby on 3/4/19.
//  Copyright © 2019 baby. All rights reserved.
//

import Foundation

enum LensCategory: Int, Equatable {
	case experience = 0
	case designer = 1
	case process = 2
	case player = 3
	case game = 4
}

extension LensCategory {
	var description: String {
		switch self {
		case .experience:
			return "Experience"
		case .designer:
			return "Designer"
		case .process:
			return "Process"
		case .player:
			return "Player"
		case .game:
			return "Game"
		}
	}
}
