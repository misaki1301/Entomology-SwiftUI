//
//  Persistence.swift
//  Entomology
//
//  Created by Paul Pacheco on 30/05/23.
//

import CoreData
import Foundation

class CoreDataProvider {
	var persistentContainer: NSPersistentContainer

	static let shared = CoreDataProvider()

	var viewContext: NSManagedObjectContext {
		persistentContainer.viewContext
	}

	// A test configuration for SwiftUI previews
	static var preview: CoreDataProvider = {
		let controller = CoreDataProvider(inMemory: true)
		// create user
		// create bugs

		return controller
	}()

	init(inMemory: Bool = false) {
		persistentContainer = NSPersistentContainer(name: "Entomology")
		if inMemory {
			persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
		}
		persistentContainer.loadPersistentStores { _, error in
			if let error {
				fatalError("Unable to initialize Entomology \(error)")
			}
		}
	}
}
