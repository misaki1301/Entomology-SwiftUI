//
//  ViewExtension.swift
//  Entomology
//
//  Created by Paul Pacheco on 30/05/23.
//

import Foundation
import SwiftUI

struct BackgroundColorModifier: ViewModifier {
	let backgroundColor: Color

	func body(content: Content) -> some View {
		ZStack {
			backgroundColor.edgesIgnoringSafeArea(.all)
			content
		}
	}
}

#if canImport(UIKit)
extension View {
	func backgroundColor(_ color: Color) -> some View {
		modifier(BackgroundColorModifier(backgroundColor: color))
	}

	func hideKeyboard() {
		let resign = #selector(UIResponder.resignFirstResponder)
		UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
	}
}
#endif
