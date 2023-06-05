//
//  ViewRouter.swift
//  Entomology
//
//  Created by Paul Pacheco on 1/06/23.
//

import Foundation

class ViewRouter: ObservableObject {
	@Published var currentPage: Page = .splashScreen
}

enum Page {
	case splashScreen
	case signInPage
	case signUpPage
	case homePage
	case adminHomePage
}
