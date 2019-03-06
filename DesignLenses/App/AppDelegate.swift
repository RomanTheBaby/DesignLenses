//
//  AppDelegate.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import GoogleUtilities

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	private var appCoordinator: AppCoordinator?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		FirebaseApp.configure()

		configureAppCoordinator()

		if let gai = GAI.sharedInstance() {
			// Optional: automatically report uncaught exceptions.
			gai.trackUncaughtExceptions = true

			// Optional: set Logger to VERBOSE for debug information.
			// Remove before app release.
			//		gai.logger.logLevel = .verbose;
		}

		return true
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		// Saves changes in the application's managed object context before the application terminates.

		try? Dependencies.shared.persistanceService.saveContext()
	}
}

extension AppDelegate {
	private func configureAppCoordinator() {
		appCoordinator = AppCoordinator()
		appCoordinator?.start()
	}
}

