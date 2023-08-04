//
//  EditCountRecordView.swift
//  EntomologyTests
//
//  Created by Paul Pacheco on 4/08/23.
//

import XCTest
import SwiftUI
import ViewInspector
import SwiftPrettyPrint
@testable import Entomology

final class EditCountRecordViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
	
	func testUpdateCountRecord() throws {
		let context = CoreDataProvider.currentContext
		let record = try context.fetch(CountRecord.getByDate()).first{$0.insect?.speciesName == "Abeja"}!
		let bindedRecord = Binding<CountRecord>(wrappedValue: record)
		let editView = EditCountRecordView(record: bindedRecord)
		let expect = editView.inspection.inspect() { view in
			try view.actualView().record.count += 1
			try view.find(button: "Guardar").tap()
			XCTAssertEqual(try view.actualView().record.count, 21)
			XCTAssertEqual(try view.actualView().record.comment, "wow, such amount of insects I found yesterday")
			XCTAssertEqual(try view.actualView().record.location, "Lima, Peru")
		}
		ViewHosting.host(view: editView.environmentObject(ViewRouter()))
		
		self.wait(for: [expect], timeout: 1.5)
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
