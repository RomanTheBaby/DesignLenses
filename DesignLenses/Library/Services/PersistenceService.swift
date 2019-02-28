//
//  PersistenceService.swift
//  DesignLenses
//
//  Created by Baby on 2/28/19.
//  Copyright © 2019 baby. All rights reserved.
//

import CoreData
import Foundation

protocol PersistenceServiceProtocol {
	var context: NSManagedObjectContext { get }
	var persistentContainer: NSPersistentContainer { get }

	func saveContext() throws
	func delete(_ object: NSManagedObject) throws
	func fetchAllObjects<T: NSManagedObject>() -> [T]
}

final class PersistenceService: PersistenceServiceProtocol {

	var context: NSManagedObjectContext {
		return persistentContainer.viewContext
	}

	lazy var persistentContainer: NSPersistentContainer = {

		/*
		The persistent container for the application. This implementation
		creates and returns a container, having loaded the store for the
		application to it. This property is optional since there are legitimate
		error conditions that could cause the creation of the store to fail.
		*/

		let container = NSPersistentContainer(name: "CardShare")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

				/*
				Typical reasons for an error here include:
				* The parent directory does not exist, cannot be created, or disallows writing.
				* The persistent store is not accessible, due to permissions or data protection when the device is locked.
				* The device is out of space.
				* The store could not be migrated to the current model version.
				Check the error message to determine what the actual problem was.
				*/
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()

	init() {}

	// MARK: - Core Data Saving support

	func saveContext() throws {
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				debugPrint("Failed to save context with error: \(error.localizedDescription)")
				//throw error
				fatalError("Failed to save context with error: \(error.localizedDescription)")
			}
		}
	}

	// MARK: - CoreData Deleting

	func delete(_ object: NSManagedObject) throws {
		context.delete(object)
		try saveContext()
	}

	// MARK: - CoreData Fetching

	func fetchAllObjects<T: NSManagedObject>() -> [T] {
		guard let fetchedEntities = try? context.fetch(T.fetchRequest()),
			let unwrappedEntities = fetchedEntities as? [T]
			else { return [] }
		return unwrappedEntities
	}
}
