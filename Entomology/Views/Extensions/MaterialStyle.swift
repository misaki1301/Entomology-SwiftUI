//
//  MaterialButtonStyle.swift
//  tictactoe2
//
//  Created by Paul Pacheco on 25/05/23.
//

import Foundation
import SwiftUI

struct MaterialTextFieldStyle: TextFieldStyle {
	var isEditing: Bool
	// swiftlint:disable identifier_name
	func _body(configuration: TextField<_Label>) -> some View {
		configuration
			.padding(.horizontal, 56)
			.padding(.vertical, 16)
			.background(Color("button_background"))
			.font(.custom("Roboto-Regular", size: 16))
			.foregroundColor(Color("textfield_font"))
			.cornerRadius(28)
			.overlay(RoundedRectangle(cornerRadius: 28)
				.stroke(isEditing ? Color("textfield_focus_border") : Color.clear, lineWidth: 2))
	}
	// swiftlint:enable identifier_name
}

struct MaterialButtonStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		MaterialButtonStyleView(configuration: configuration)
	}
}

private extension MaterialButtonStyle {
	struct MaterialButtonStyleView: View {
		@Environment(\.isEnabled) var isEnabled
		let configuration: MaterialButtonStyle.Configuration
		var body: some View {
			return configuration.label
				.font(.custom("Roboto-Medium", size: 14))
				.foregroundColor(Color("font_primary"))
				.background(isEnabled ? Color("button_background") : Color("button_background_disabled"))
				.cornerRadius(100)
				.shadow(radius: 2, x: 0, y: 2)
				// make the button a bit more translucent when pressed
				.opacity(configuration.isPressed ? 0.8 : 1.0)
				// make the button a bit smaller when pressed
				.scaleEffect(configuration.isPressed ? 0.98 : 1.0)
		}
	}
}
