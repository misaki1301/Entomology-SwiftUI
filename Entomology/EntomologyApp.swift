//
//  EntomologyApp.swift
//  Entomology
//
//  Created by Paul Pacheco on 30/05/23.
//

import SwiftUI

@main
struct EntomologyApp: App {
    let persistenceController = PersistenceController.shared
	@StateObject var viewRouter = ViewRouter()
	@StateObject var locationViewModel = LocationViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(viewRouter)
				.environmentObject(locationViewModel)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
