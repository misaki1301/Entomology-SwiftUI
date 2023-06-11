//
//  EntomologyApp.swift
//  Entomology
//
//  Created by Paul Pacheco on 30/05/23.
//

import SwiftUI

@main
struct EntomologyApp: App {
	let persistenceController = CoreDataProvider.shared
	@StateObject var viewRouter = ViewRouter()
	@StateObject var locationViewModel = LocationViewModel()
	@StateObject var entomologistViewModel = EntomologistViewModel()

	var body: some Scene {
		WindowGroup {
			ContentView()
				.environmentObject(viewRouter)
				.environmentObject(locationViewModel)
				.environmentObject(entomologistViewModel)
				.environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
		}
	}
}
