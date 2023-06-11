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
		ZStack {
			switch viewRouter.currentPage {
			case .splashScreen:
				SplashView()
			case .signUpPage:
				RegisterUserView()
			case .homePage:
				HomeView()
			default:
				SplashView()
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(ViewRouter())
	}
}
