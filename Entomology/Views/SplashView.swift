//
//  SplashView.swift
//  Entomology
//
//  Created by Paul Pacheco on 30/05/23.
//

import SwiftUI

struct MaterialButton: View {
	var text: String
	var action: () -> Void
	var body: some View {
		Button(action: action) {
			Text(text)
				.padding(.vertical, 10)
				.padding(.horizontal, 24)
		}.buttonStyle(MaterialButtonStyle())
	}
}

struct SplashView: View {
	@EnvironmentObject var viewRouter: ViewRouter
	var body: some View {
		VStack {
			Spacer()
			Image(systemName: "swift")
			Image("entomology_logo")
			Spacer()
			HStack(spacing: 47) {
				MaterialButton(text: "Ingreso primera vez", action: goToSignUp)
				MaterialButton(text: "Ingreso", action: goToSignIn)
			}
			Spacer()
		}.backgroundColor(Color("background"))
	}
	private func goToSignUp() {
		viewRouter.currentPage = .signUpPage
	}
	private func goToSignIn() {
		viewRouter.currentPage = .signInPage
	}
}

struct SplashView_Previews: PreviewProvider {
	static var previews: some View {
		SplashView()
			.environmentObject(ViewRouter())
	}
}
