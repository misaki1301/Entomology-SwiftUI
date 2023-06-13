//
//  SplashView.swift
//  Entomology
//
//  Created by Paul Pacheco on 30/05/23.
//

import CoreData
import SwiftUI

struct SplashView: View {
	@Environment(\.managedObjectContext) private var viewContext
	@EnvironmentObject var viewRouter: ViewRouter
	@EnvironmentObject var entomolgistViewModel: EntomologistViewModel

	var body: some View {
		VStack {
			Spacer()
			Image(systemName: "swift")
			Image("entomology_logo")
			Spacer()
			Spacer()
		}.backgroundColor(Color("background"))
			.onAppear {
				entomolgistViewModel.getUser()
			}
	}

	private func goToSignUp() {
		viewRouter.currentPage = .signUpPage
	}

	private func goToSignIn() {
		viewRouter.currentPage = .homePage
	}
}

struct SplashView_Previews: PreviewProvider {
	static var previews: some View {
		SplashView()
			.environmentObject(ViewRouter())
			.environmentObject(EntomologistViewModel())
			.environment(\.managedObjectContext, CoreDataProvider.preview.persistentContainer.viewContext)
	}
}
