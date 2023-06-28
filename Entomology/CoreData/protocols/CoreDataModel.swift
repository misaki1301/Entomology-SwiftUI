//
//  CoreDataModel.swift
//  Entomology
//
//  Created by Paul Pacheco on 5/06/23.
//

import Foundation
import CoreData

protocol Model {
	func save() throws
	func delete() throws
}

extension Model where Self: NSManagedObject {
	func save() throws {
		try CoreDataProvider.shared.viewContext.save()
	}
	func delete() throws {
		CoreDataProvider.shared.viewContext.delete(self)
		try save()
	}
	static var all: NSFetchRequest<Self> {
		let request = NSFetchRequest<Self>(entityName: String(describing: self))
		request.sortDescriptors = []
		return request
	}
}
