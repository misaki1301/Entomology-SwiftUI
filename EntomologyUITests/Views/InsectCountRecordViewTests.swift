//
//  InsectCountRecordViewTests.swift
//  EntomologyUITests
//
//  Created by Paul Pacheco on 22/06/23.
//

import XCTest

final class InsectCountRecordViewTests: XCTestCase {

	private var app: XCUIApplication!
	
	override func setUp() {
		continueAfterFailure = false
		app = XCUIApplication()
		app.launchArguments = ["-ui-testing"]
		app.launchEnvironment = ["-networking-success": "1"]
		app.launch()
	}
	
	override func tearDown() {
		app = nil
	}
	
	func testForCounterExistencenInsectCountRecordView() {
		let splashScreen = app.otherElements["splash_screen"]
		
		// Wait for the splash screen to disappear
		let splashScreenDisappeared = XCTNSPredicateExpectation(
			predicate: NSPredicate(format: "exists == false"),
			object: splashScreen
		)
		_ = XCTWaiter.wait(for: [splashScreenDisappeared], timeout: 2.5)
		
		// Continue with your assertions and tests
		XCTAssert(true)
		
		//Go to create new record view
		let navLink = app.otherElements.buttons["new_count_record_button"]
		XCTAssertTrue(navLink.waitForExistence(timeout: 5))
		
		navLink.tap()
		//let textcomplete = app.otherElements.collectionViews["text_autocomplete_insects"]
		//textcomplete.tap()
		//let textField = app.textFields.matching(identifier: "text_autocomplete").element
		let holder = app.otherElements["textfield_holder_insect"]
		XCTAssertTrue(holder.waitForExistence(timeout: 5), "No existe el holder de los inputs")
		let textField = app.descendants(matching: .other).element(boundBy: 2)
		//let textField = app.otherElements.firstMatch
		textField.tap()
			textField.typeText("Hello, World!")
		XCTAssertTrue(textField.waitForExistence(timeout: 5))
		textField.typeText("abej")
		
		
		
		let expectedView = app.staticTexts["InsectFormView"]
		
		XCTAssertTrue(expectedView.waitForExistence(timeout: 5))
		
		//go to countrecord view
		let labelButton = NSPredicate(format: "label beginsWith 'Seleccionar'")
		let navLinkRecord = app.buttons.element(matching: labelButton)
		XCTAssertTrue(navLinkRecord.waitForExistence(timeout: 3), "navLinkRecord doesn't exists in current view")
		navLinkRecord.tap()
		
		//check in insectCountRecordView
		let counterText = app.staticTexts["counter_text"]
		XCTAssertTrue(counterText.waitForExistence(timeout: 5), "Check failed for label existance")
		
		XCTAssertTrue(counterText.exists && !counterText.frame.isEmpty)
	}
	
	func testForFabExistenceOnInsectCountRecordView() {
		let splashScreen = app.otherElements["splash_screen"]
		
		// Wait for the splash screen to disappear
		let splashScreenDisappeared = XCTNSPredicateExpectation(
			predicate: NSPredicate(format: "exists == false"),
			object: splashScreen
		)
		_ = XCTWaiter.wait(for: [splashScreenDisappeared], timeout: 2.5)
		
		// Continue with your assertions and tests
		XCTAssert(true)
		
		//Go to create new record view
		let navLink = app.otherElements.buttons["new_count_record_button"]
		XCTAssertTrue(navLink.waitForExistence(timeout: 5))
		
		navLink.tap()
		
		let expectedView = app.staticTexts["InsectFormView"]
		
		XCTAssertTrue(expectedView.waitForExistence(timeout: 5))
		
		//go to countrecord view
		let labelButton = NSPredicate(format: "label beginsWith 'Seleccionar'")
		let navLinkRecord = app.buttons.element(matching: labelButton)
		XCTAssertTrue(navLinkRecord.waitForExistence(timeout: 3), "navLinkRecord doesn't exists in current view")
		navLinkRecord.tap()
		
		let fabMinus = app.buttons["fab_minus"]
		let fabPlus = app.buttons["fab_plus"]
		XCTAssertTrue(fabMinus.waitForExistence(timeout: 3), "the button does not exists")
		XCTAssertTrue(fabPlus.waitForExistence(timeout: 3), "the button does not exists")
	}
	
	func testForFabAddingValuesOnInsectCountRecordView() {
		let splashScreen = app.otherElements["splash_screen"]
		
		// Wait for the splash screen to disappear
		let splashScreenDisappeared = XCTNSPredicateExpectation(
			predicate: NSPredicate(format: "exists == false"),
			object: splashScreen
		)
		_ = XCTWaiter.wait(for: [splashScreenDisappeared], timeout: 2.5)
		
		// Continue with your assertions and tests
		XCTAssert(true)
		
		//Go to create new record view
		let navLink = app.otherElements.buttons["new_count_record_button"]
		XCTAssertTrue(navLink.waitForExistence(timeout: 5))
		
		navLink.tap()
		
		let expectedView = app.staticTexts["InsectFormView"]
		
		XCTAssertTrue(expectedView.waitForExistence(timeout: 5))
		
		//go to countrecord view
		let labelButton = NSPredicate(format: "label beginsWith 'Seleccionar'")
		let navLinkRecord = app.buttons.element(matching: labelButton)
		XCTAssertTrue(navLinkRecord.waitForExistence(timeout: 3), "navLinkRecord doesn't exists in current view")
		navLinkRecord.tap()
		
		//get button fab for adding values to label
		let fabPlus = app.otherElements.buttons["fab_plus"]
		let counterText = app.staticTexts["counter_text"]
		XCTAssertTrue(counterText.waitForExistence(timeout: 5), "Check failed for label existance")
		XCTAssertTrue(fabPlus.waitForExistence(timeout: 3), "the button does not exists")
		fabPlus.tap()
		fabPlus.tap()
		XCTAssertEqual(counterText.label, "02")
	}
	
	func testForFabAddingAndRemovingValuesOnInsectCountRecordView() {
		let splashScreen = app.otherElements["splash_screen"]
		
		// Wait for the splash screen to disappear
		let splashScreenDisappeared = XCTNSPredicateExpectation(
			predicate: NSPredicate(format: "exists == false"),
			object: splashScreen
		)
		_ = XCTWaiter.wait(for: [splashScreenDisappeared], timeout: 2.5)
		
		// Continue with your assertions and tests
		XCTAssert(true)
		
		//Go to create new record view
		let navLink = app.otherElements.buttons["new_count_record_button"]
		XCTAssertTrue(navLink.waitForExistence(timeout: 5))
		
		navLink.tap()
		
		let expectedView = app.staticTexts["InsectFormView"]
		
		XCTAssertTrue(expectedView.waitForExistence(timeout: 5))
		
		//go to countrecord view
		let labelButton = NSPredicate(format: "label beginsWith 'Seleccionar'")
		let navLinkRecord = app.buttons.element(matching: labelButton)
		XCTAssertTrue(navLinkRecord.waitForExistence(timeout: 3), "navLinkRecord doesn't exists in current view")
		navLinkRecord.tap()
		
		//get button fab for adding values to label
		let fabPlus = app.buttons["fab_plus"]
		let fabMinus = app.buttons["fab_minus"]
		//check in insectCountRecordView
		let counterText = app.staticTexts["counter_text"]
		XCTAssertTrue(counterText.waitForExistence(timeout: 5), "Check failed for label existance")
		XCTAssertTrue(fabPlus.waitForExistence(timeout: 3), "the button does not exists")
		XCTAssertTrue(fabMinus.waitForExistence(timeout: 3), "the button does not exists")
		fabPlus.tap()
		fabPlus.tap()
		XCTAssertEqual(counterText.label, "02")
		fabMinus.tap()
		fabMinus.tap()
		XCTAssertEqual(counterText.label, "00")
	}
}
