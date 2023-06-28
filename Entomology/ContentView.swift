//
//  ContentView.swift
//  Entomology
//
//  Created by Paul Pacheco on 30/05/23.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject var viewRouter: ViewRouter

	var body: some View {
		//var isDebug = false
		#if DEBUG
		var isDebug = true
		let userId = !(UITestingHelper.isUITesting || UITestingHelper.isInPreview) ? AppData.defaultUserId : AppData.defaultTestUserId
		#else
		var isDebug = false
		let userId = AppData.defaultUserId
		#endif
		ZStack {
			switch viewRouter.currentPage {
			case .splashScreen:
					SplashView().accessibilityIdentifier("splash_screen")
			case .signUpPage:
				RegisterUserView()
			case .homePage:
				HomeView()
			default:
				SplashView()
			}
		}.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
				withAnimation {
					if userId.isEmpty {
						print("isDEBUG \(isDebug) \n \(UITestingHelper.isUITesting)")
						viewRouter.currentPage = .signUpPage
					} else {
						print("isDEBUG \(isDebug) \n \(UITestingHelper.isUITesting) \n User is not Empty")
						viewRouter.currentPage = .homePage
					}
				}
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(ViewRouter())
			.environmentObject(EntomologistViewModel())
			.environmentObject(LocationViewModel())
			.environment(\.managedObjectContext, CoreDataProvider.preview.persistentContainer.viewContext)
	}
}
