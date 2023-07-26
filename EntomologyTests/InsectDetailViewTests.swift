//
//  InsectDetailViewTests.swift
//  EntomologyTests
//
//  Created by Paul Pacheco on 14/07/23.
//

import XCTest
import SwiftUI
import ViewInspector
import MapKit
@testable import Entomology

final class InsectDetailViewTests: XCTestCase {

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
		let context = CoreDataProvider.preview.persistentContainer.viewContext
		let record = CountRecord(context: CoreDataProvider.preview.viewContext)
		record.comment = "comment example"
		record.count = 5
		record.createdAt = Date()
		record.location = "Narnia"
		let insect = Insect(context: CoreDataProvider.preview.viewContext)
		insect.speciesName = "Bee"
		insect.urlPhoto = "https://static.wikia.nocookie.net/agustin-sepulveda-fanon/images/7/7b/Abeja.png/revision/latest/thumbnail/width/360/height/360?cb=20180620011627&path-prefix=es"
		let coordinates = CLLocationCoordinate2D(latitude: 35.30487705019497, longitude: 139.48254879527659)
		let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
		let region = MKCoordinateRegion(center: coordinates, span: span)
		let locate = GeoLocate(context: CoreDataProvider.preview.viewContext)
		locate.latitude = 35.30487705019497
		locate.longitude = 139.48254879527659
		record.geolocate = locate
		record.insect = insect
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
