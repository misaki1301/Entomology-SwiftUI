//
//  EntomologyApp.swift
//  Entomology
//
//  Created by Paul Pacheco on 30/05/23.
//

import SwiftUI

@main
struct EntomologyApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	let persistenceController = UITestingHelper.isUITesting ? CoreDataProvider.preview : CoreDataProvider.shared
	@StateObject var viewRouter = ViewRouter()
	@StateObject var locationViewModel = LocationViewModel()
	@StateObject var entomologistViewModel = EntomologistViewModel()

	var body: some Scene {
		WindowGroup {
			ContentView()
				.environmentObject(viewRouter)
				.environmentObject(locationViewModel)
				.environmentObject(entomologistViewModel)
				.environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
		}
	}
}

class AppDelegate: UIResponder, UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		#if DEBUG
		print("🤖 is a UI Test Running \(UITestingHelper.isUITesting) \n test \(AppData.defaultTestUserId) \n default \(AppData.defaultUserId)")
		print("is in Preview \(UITestingHelper.isInPreview)")
		#endif
		return true
	}
}
