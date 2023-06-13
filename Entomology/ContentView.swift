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
		}.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
				withAnimation {
					if AppData.defaultUserId.isEmpty {
						viewRouter.currentPage = .signUpPage
					} else {
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
	}
}
