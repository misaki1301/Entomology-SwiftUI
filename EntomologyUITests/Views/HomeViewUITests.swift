//
//  HomeViewUITests.swift
//  EntomologyUITests
//
//  Created by Paul Pacheco on 15/06/23.
//

import XCTest
final class HomeViewUITests: XCTestCase {
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
	
	private func waitForSplashScreen() {
		let splashScreen = app.otherElements["splash_screen"]
		
		// Wait for the splash screen to disappear
		let splashScreenDisappeared = XCTNSPredicateExpectation(
			predicate: NSPredicate(format: "exists == false"),
			object: splashScreen
		)
		_ = XCTWaiter.wait(for: [splashScreenDisappeared], timeout: 2.5)
		
		// Continue with your assertions and tests
		XCTAssert(true)
	}
	
	func testHasImageProfile() {
		
		let splashScreen = app.otherElements["splash_screen"]
		
		// Wait for the splash screen to disappear
		let splashScreenDisappeared = XCTNSPredicateExpectation(
			predicate: NSPredicate(format: "exists == false"),
			object: splashScreen
		)
		_ = XCTWaiter.wait(for: [splashScreenDisappeared], timeout: 2.5)
		
		// Continue with your assertions and tests
		XCTAssert(true)
		
		let imageView = app.images["profileImage"]
		XCTAssertTrue(imageView.waitForExistence(timeout: 5), "The profile image of the current entomologist")
		
		XCTAssertTrue(imageView.isHittable && !imageView.frame.isEmpty)
	}
	
	func testNavigationFromNewRecordButtonToCountRecordView() {
		let splashScreen = app.otherElements["splash_screen"]
		
		// Wait for the splash screen to disappear
		let splashScreenDisappeared = XCTNSPredicateExpectation(
			predicate: NSPredicate(format: "exists == false"),
			object: splashScreen
		)
		_ = XCTWaiter.wait(for: [splashScreenDisappeared], timeout: 2.5)
		
		// Continue with your assertions and tests
		XCTAssert(true)
		
		let navLink = app.otherElements.buttons["new_count_record_button"]
		XCTAssertTrue(navLink.waitForExistence(timeout: 5))
		
		navLink.tap()
		
		let expectedView = app.staticTexts["InsectFormView"]
		
		XCTAssertTrue(expectedView.waitForExistence(timeout: 5))
	}
	
//	func testNavigationFromItemHomeView() {
//		let splashScreen = app.otherElements["splash_screen"]
//
//		// Wait for the splash screen to disappear
//		let splashScreenDisappeared = XCTNSPredicateExpectation(
//			predicate: NSPredicate(format: "exists == false"),
//			object: splashScreen
//		)
//		_ = XCTWaiter.wait(for: [splashScreenDisappeared], timeout: 2.5)
//
//		// Continue with your assertions and tests
//		XCTAssert(true)
//
//		//appears that collectionViews are related to VStack and HStack will try to test Lazy variants later on
//		let list = app.collectionViews["list_holder"]
//		XCTAssertTrue(list.waitForExistence(timeout: 3), "the list VStack View not exists in homeView")
//		let lister = app.otherElements.tables["list_home"]
//		XCTAssertTrue(lister.waitForExistence(timeout: 3), "the list not exists in HomeView")
//	}
	
	
	func testExistenceLabelNewCountInHomeView() {
		let splashScreen = app.otherElements["splash_screen"]
		
		// Wait for the splash screen to disappear
		let splashScreenDisappeared = XCTNSPredicateExpectation(
			predicate: NSPredicate(format: "exists == false"),
			object: splashScreen
		)
		_ = XCTWaiter.wait(for: [splashScreenDisappeared], timeout: 2.5)
		
		// Continue with your assertions and tests
		XCTAssert(true)
		
		let label = NSPredicate(format: "label beginsWith 'Nuevo conteo'")
		let labelNewCount = app.staticTexts.element(matching: label)
		XCTAssertTrue(labelNewCount.waitForExistence(timeout: 3), "label nuevo conteo no existe en pantalla Home")
		
	}
}
