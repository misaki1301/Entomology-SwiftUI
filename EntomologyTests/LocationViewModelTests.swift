//
//  LocationViewModel.swift
//  EntomologyTests
//
//  Created by Paul Pacheco on 5/07/23.
//

import XCTest
@testable import Entomology
import CoreLocation

final class LocationViewModelTests: XCTestCase {
	
	var viewModel: LocationViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		XCUIDevice.shared.location = XCUILocation(location: CLLocation(latitude: 35.305873, longitude: 139.482749))
		viewModel = LocationViewModel()
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
	
	func testLocation() async throws {
		let vm = LocationViewModel()
		//vm.lastSeenLocation
		await vm.fetchCountryAndCity(for: vm.lastSeenLocation)
		print("has a country logged \(vm.currentPlacemark?.country)")
		XCTAssertTrue(vm.authorizationStatus == .authorizedAlways || vm.authorizationStatus == .authorizedWhenInUse)
		
	}
	
//	func testLocationServicesDisable() throws {
//		XCTAssertTrue(viewModel.authorizationStatus == .denied || viewModel.authorizationStatus == .notDetermined)
//	}
	
	func testIsLocationServicesActive() throws {
		let vm = LocationViewModel()
		XCTAssertTrue(vm.authorizationStatus == .authorizedWhenInUse || vm.authorizationStatus == .authorizedAlways)
	}
	
	func testfetchCountryAndCity() async throws {
		XCTAssertTrue(viewModel.authorizationStatus == .authorizedAlways || viewModel.authorizationStatus == .authorizedWhenInUse)
		XCTAssertTrue(viewModel.isPermissionActive, "el permiso de localizacion GPS esta desactivado")
		let location = CLLocation(latitude: 35.305873, longitude: 139.482749)
		await viewModel.fetchCountryAndCity(for: location)
		print("testIsLocated \(viewModel.currentPlacemark)")
		if let placemark = viewModel.currentPlacemark {
			print("has placemark on it \(placemark.country)")
			XCTAssertEqual(placemark.country, "Japan")
		} else {
			XCTAssertNil(viewModel.currentPlacemark, "has nil as currentPlacemark")
		}
	}
	
	func testFetchCountryAndCity() async throws {
		let location: CLLocation? = nil
		await viewModel.fetchCountryAndCity(for: location)
		XCTAssertNil(viewModel.currentPlacemark, "the placemark is not nil")
	}

}
