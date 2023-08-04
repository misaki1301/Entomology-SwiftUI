//
//  CreateInsectViewTests.swift
//  EntomologyTests
//
//  Created by Paul Frank Pacheco Carpio on 21/07/23.
//
import SwiftUI
import ViewInspector
@testable import Entomology

import XCTest

final class CreateInsectViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
	
	func testStates() throws {
		let context = CoreDataProvider.currentContext
		let insect = Binding<Insect?>(wrappedValue: nil)
		let createView = CreateInsectView(newInsect: insect)
		
		let expectation = createView.inspection.inspect() { view in
			let textfieldName = try view.find(viewWithAccessibilityIdentifier: "textfield_insect_name").textField()
			try textfieldName.setInput("Hormiga")
			try view.find(viewWithAccessibilityIdentifier: "textfield_insect_url").textField().setInput("none")
			print(try view.actualView().name)
			XCTAssertEqual(try view.actualView().name, "Hormiga", "the text name is not equal")
			XCTAssertEqual(try view.actualView().url, "none", "the text url is not equal")
		}
		
		ViewHosting.host(view: createView)
		
		self.wait(for: [expectation], timeout: 1.5)
	}
	
	func testCreateNewInsect() throws {
		let context = CoreDataProvider.currentContext
		let insect = Binding<Insect?>(wrappedValue: nil)
		let createView = CreateInsectView(newInsect: insect)
		
		let expectation = createView.inspection.inspect() { view in
			let textfieldName = try view.find(viewWithAccessibilityIdentifier: "textfield_insect_name").textField()
			try textfieldName.setInput("Hormiga")
			try view.actualView().image = UIImage(named: "ant")!
			try view.find(viewWithAccessibilityIdentifier: "textfield_insect_url").textField().setInput("none")
			print(try view.actualView().name)
			XCTAssertEqual(try view.actualView().name, "Hormiga", "the text name is not equal")
			XCTAssertEqual(try view.actualView().url, "none", "the text url is not equal")
			XCTAssertNotNil(try view.actualView().image, "image state is null")
			let buttonSave = try view.find(button: "Seleccionar")
			try buttonSave.tap()
			XCTAssertNotNil(insect.wrappedValue, "the instance of insect is nil")
		}
		
		ViewHosting.host(view: createView)
		
		self.wait(for: [expectation], timeout: 1.5)
	}


}
