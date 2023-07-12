//
//  InsectCountRecordViewTests.swift
//  EntomologyTests
//
//  Created by Paul Pacheco on 11/07/23.
//
import XCTest
import SwiftUI
import ViewInspector
@testable import Entomology

final class InsectCountRecordViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

	
	func testParamsPassedExists() throws {
		let context = CoreDataProvider.preview.persistentContainer.viewContext
		let view = InsectCountRecordView(name: "desconocido", image: UIImage(named: "ant")!, count: 20, url: "", comment: "XD")
		
		let expectation = view.inspection.inspect { item in
			XCTAssertEqual(view.name, "desconocido")
			XCTAssertEqual(view.count, 20)
			XCTAssertEqual(view.comment, "XD")
		}
		
		ViewHosting.host(view: view.environmentObject(LocationViewModel()).environmentObject(ViewRouter()).environmentObject(EntomologistViewModel()))
		
		
		self.wait(for: [expectation], timeout: 1.5)
		//view.saveToEntomologist()
		//let records = try? context.fetch(CountRecord.getByDate())
		//XCTAssertEqual(view.count, records?.first?.count, "The record is not the same!")
	}
	
	func testSaveToEntomologist() throws {
		let context = CoreDataProvider.preview.persistentContainer.viewContext
		let view = InsectCountRecordView(name: "desconocido", image: UIImage(named: "ant")!, count: 20, url: "", comment: "XD")
		
		let expectation = view.inspection.inspect { item in
			XCTAssertEqual(view.name, "desconocido")
			XCTAssertEqual(view.count, 20)
			XCTAssertEqual(view.comment, "XD")
			let button = try item.find(button: "Guardar")
			try button.tap()
			let records = try context.fetch(CountRecord.getByDate())
			XCTAssertEqual(view.count, records.first?.count)
			XCTAssertEqual(view.name, records.first?.insect?.speciesName)
		}
		
		ViewHosting.host(view: view.environmentObject(LocationViewModel()).environmentObject(ViewRouter()).environmentObject(EntomologistViewModel()).environment(\.managedObjectContext, context))
		
		
		self.wait(for: [expectation], timeout: 1.5)
	}

}
