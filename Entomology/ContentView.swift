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
				default:
					SplashView()
			}
		}
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
			.environmentObject(ViewRouter())
    }
}
