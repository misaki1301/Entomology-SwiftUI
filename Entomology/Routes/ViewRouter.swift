//
//  ViewRouter.swift
//  Entomology
//
//  Created by Paul Pacheco on 1/06/23.
//

import Foundation

class ViewRouter: ObservableObject {
	@Published var currentPage: Page = .splashScreen
	@Published var returnToHome = false
}

enum Page: String {
	case splashScreen
	case signInPage
	case signUpPage
	case homePage
	case adminHomePage
}
