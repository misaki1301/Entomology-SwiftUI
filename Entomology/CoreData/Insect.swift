//
//  ModelInsect.swift
//  Entomology
//
//  Created by Paul Pacheco on 2/06/23.
//
import CoreData
import Foundation

class Insect: NSManagedObject {}

extension Insect {
	@NSManaged var speciesName: String?
	@NSManaged var urlPhoto: String?
	@NSManaged var localePhoto: Data?
	@NSManaged var locate: String?
	@NSManaged var moreInfoUrl: String?
	@NSManaged var countRecords: NSSet?
	@nonobjc public class func fetchRequest() -> NSFetchRequest<Insect> {
		return NSFetchRequest<Insect>(entityName: "Insect")
	}
}

extension Insect: Identifiable {}

extension Insect: Model {
	static func getList() -> NSFetchRequest<Insect> {
		let request = Insect.fetchRequest()
		request.sortDescriptors = []
		return request
	}
	
	static func searchByName(searchTerm: String) -> NSFetchRequest<Insect> {
		let request = Insect.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "speciesName", ascending: false)]
		request.predicate = NSPredicate(format: "speciesName BEGINSWITH[c] %@", searchTerm)
		return request
	}
	
	static func countBySpecie() -> NSFetchRequest<Insect> {
		let request = Insect.fetchRequest()
		request.sortDescriptors = []
		let sumExp = NSExpressionDescription()
		sumExp.name = "total_count"
		sumExp.expression = NSExpression(format: "@sum.countRecords.count")
		sumExp.expressionResultType = .integer32AttributeType
		
		request.propertiesToFetch = ["speciesName", sumExp]
		
		request.propertiesToGroupBy = ["speciesName"]
		
		request.resultType = .dictionaryResultType
		
		return request
	}
	
	static func fetchTotalCountPerInsect() -> [[String: Any]]? {
		let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "Insect")

		// Define the SUM expression for the CountRecord's "count" attribute
		let sumExpression = NSExpressionDescription()
		sumExpression.name = "totalCount"
		sumExpression.expression = NSExpression(format: "@sum.countRecords.count")
		sumExpression.expressionResultType = .integer32AttributeType

		// Set the properties to fetch (insect's attributes and the calculated sum)
		fetchRequest.propertiesToFetch = ["speciesName", "urlPhoto", "localePhoto", "locate", "moreInfoUrl", sumExpression]

		// Group by the Insect entity
		fetchRequest.propertiesToGroupBy = ["speciesName", "urlPhoto", "localePhoto", "locate", "moreInfoUrl"]

		// Specify the result format
		fetchRequest.resultType = .dictionaryResultType

		do {
			let context = CoreDataProvider.currentContext
			let result = try context.fetch(fetchRequest)
			return convertToSwiftDictionaries(from: result)
		} catch {
			print("Error fetching data: \(error)")
			return nil
		}
	}
}
