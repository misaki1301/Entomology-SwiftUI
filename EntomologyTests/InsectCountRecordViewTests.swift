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
		let context = CoreDataProvider.currentContext
		let insect = Insect(context: context)
		insect.speciesName = "desconocido"
		insect.localePhoto = UIImage(named: "ant")?.pngData()
		insect.moreInfoUrl = ""
	let view = InsectCountRecordView(insect: insect, count: 20,comment: "XD")
		
		let expectation = view.inspection.inspect { item in
			XCTAssertEqual(view.insect?.speciesName, "desconocido")
			XCTAssertEqual(view.count, 20)
			XCTAssertEqual(view.comment, "XD")
		}
		
		ViewHosting.host(view: view.environmentObject(LocationViewModel()).environmentObject(ViewRouter()).environmentObject(EntomologistViewModel()))
		
		self.wait(for: [expectation], timeout: 1.5)
	}
	
	func testSaveToEntomologist() throws {
		let context = CoreDataProvider.preview.viewContext
		let insect = Insect(context: context)
		insect.speciesName = "desconocido"
		insect.localePhoto = UIImage(named: "ant")?.pngData()
		insect.moreInfoUrl = ""
		
		let view = InsectCountRecordView(insect: insect, count: 20, comment: "XD")
		
		let expectation = view.inspection.inspect { v in
			XCTAssertEqual(try v.actualView().insect?.speciesName, "desconocido")
			XCTAssertEqual(try v.actualView().count, 20)
			XCTAssertEqual(try v.actualView().comment, "XD")
			XCTAssertEqual(try v.actualView().insect?.moreInfoUrl, "")
			XCTAssertNotNil(try v.actualView().insect?.localePhoto, "the image is nil")
			let button = try v.find(button: "Guardar")
			try button.tap()
			let records = try context.fetch(CountRecord.getByDate())
			XCTAssertEqual(try v.actualView().count, records.first?.count)
			XCTAssertEqual(try v.actualView().insect?.speciesName, records.first?.insect?.speciesName)
		}
		
		ViewHosting.host(view: view
			.environmentObject(LocationViewModel())
			.environmentObject(ViewRouter()).environmentObject(EntomologistViewModel())
			.environment(\.managedObjectContext, context))
		
		
		self.wait(for: [expectation], timeout: 1.5)
	}

}
