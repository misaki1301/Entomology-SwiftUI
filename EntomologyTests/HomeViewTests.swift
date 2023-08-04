//
//  HomeViewTests.swift
//  EntomologyTests
//
//  Created by Paul Frank Pacheco Carpio on 4/08/23.
//

import XCTest
import SwiftUI
import ViewInspector
import SwiftPrettyPrint
@testable import Entomology

final class HomeViewTests: XCTestCase {

	func testListCountBySpecimen() throws {
		let listDict = Insect.fetchTotalCountPerInsect()
		Pretty.prettyPrint(Insect.fetchTotalCountPerInsect())
		let listInsectsCount = InsectModel.convertToModel(for: listDict ?? [])
		Pretty.prettyPrint(listInsectsCount)
		XCTAssertEqual(listInsectsCount.first{$0.speciesName == "Abeja"}?.totalCount, 20)
		XCTAssertEqual(listInsectsCount.first{$0.speciesName == "Morpho"}?.totalCount, 3)
	}
	
	func testStates() throws {
		let homeView = HomeView()
		let expectation = homeView.inspection.inspect { view in
			try view.find(button: "Informes").tap()
			print("SUPER TAP")
		}
		let expect2 = homeView.inspection.inspect(after: 3) { view in
			XCTAssertEqual(try view.actualView().listInsectsCount.count, 6)
			XCTAssertEqual(try view.actualView().listInsectsCount.first{$0.speciesName == "Abeja"}?.totalCount, 20)
		}
		
		ViewHosting.host(view: homeView.environmentObject(EntomologistViewModel())
			.environmentObject(ViewRouter())
			   .environment(\.managedObjectContext, CoreDataProvider.preview.persistentContainer.viewContext))
		
		self.wait(for: [expectation, expect2], timeout: 3)
	}

}
