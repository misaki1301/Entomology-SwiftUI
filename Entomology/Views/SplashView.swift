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
		let currentUser = entomolgistViewModel.currentEntomologist
		VStack {
			Spacer()
			Image(systemName: "swift")
			Image("entomology_logo")
			// Text(AppData.defaultUserId)
			// Text(currentUser?.name ?? "F")
			// Text(viewRouter.currentPage.rawValue)
			Spacer()
			HStack(spacing: 47) {
				MaterialButton(text: "Ingreso primera vez", action: goToSignUp)
					.disabled(currentUser != nil)
				MaterialButton(text: "Ingreso", action: goToSignIn).disabled(currentUser == nil)
			}
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
			// .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
			.environment(\.managedObjectContext, CoreDataProvider.preview.persistentContainer.viewContext)
	}
}
