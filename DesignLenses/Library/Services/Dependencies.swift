//
//  Dependencies.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import Foundation

final class Dependencies {

	static let shared = Dependencies()

	private(set) lazy var persistanceService: PersistenceServiceProtocol = PersistenceService()

}
