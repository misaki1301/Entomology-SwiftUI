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

struct MaterialFabButtonStyle: ButtonStyle {
	var color = "background"
	func makeBody(configuration: Configuration) -> some View {
		MaterialFabButtonStyleView(color: color, configuration: configuration)
	}
}

private extension MaterialFabButtonStyle {
	struct MaterialFabButtonStyleView: View {
		var color = "background"
		@Environment(\.isEnabled) var isEnabled
		let configuration: MaterialFabButtonStyle.Configuration
		var body: some View {
			return configuration.label
				.font(.custom("Roboto-Medium", size: 14))
				.padding(.all, 20)
				.foregroundColor(Color("fab_text_primary"))
				.background(isEnabled ? Color(color) : Color("button_disabled_background"))
				.cornerRadius(16)
				// .shadow(radius: 2, x: 0, y: 2)
				// make the button a bit more translucent when pressed
				.opacity(configuration.isPressed ? 0.8 : 1.0)
				// make the button a bit smaller when pressed
				.scaleEffect(configuration.isPressed ? 0.98 : 1.0)
		}
	}
}

struct MaterialFillButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		MaterialFillButtonStyleView(configuration: configuration)
	}
}

private extension MaterialFillButtonStyle {
	struct MaterialFillButtonStyleView: View {
		@Environment(\.isEnabled) var isEnabled
		let configuration: MaterialFillButtonStyle.Configuration
		var body: some View {
			return configuration.label
				.font(.custom("Roboto-Medium", size: 14))
				.foregroundColor(.white)
				.background(isEnabled ? Color("font_primary") : Color.clear)
				.overlay(RoundedRectangle(cornerRadius: 100).stroke(!isEnabled ? Color("textfield_focus_border") : Color.clear, lineWidth: 2))
				.cornerRadius(100)
				//.shadow(radius: isEnabled ? 2 : 0, x: 0, y: isEnabled ? 2 : 0)
				// make the button a bit more translucent when pressed
				.opacity(configuration.isPressed ? 0.8 : 1.0)
				// make the button a bit smaller when pressed
				.scaleEffect(configuration.isPressed ? 0.98 : 1.0)
		}
	}
}

struct MaterialOutlinedButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		MaterialOutlinedButtonStyleView(configuration: configuration)
	}
}

private extension MaterialOutlinedButtonStyle {
	struct MaterialOutlinedButtonStyleView: View {
		@Environment(\.isEnabled) var isEnabled
		let configuration: MaterialOutlinedButtonStyle.Configuration
		var body: some View {
			return configuration.label
				.font(.custom("Roboto-Medium", size: 14))
				.foregroundColor(Color("font_primary"))
				.background(Color.clear)
				.overlay(RoundedRectangle(cornerRadius: 100).stroke(Color("textfield_focus_border"), lineWidth: 2))
				.cornerRadius(100)
				//.shadow(radius: isEnabled ? 2 : 0, x: 0, y: isEnabled ? 2 : 0)
				// make the button a bit more translucent when pressed
				.opacity(configuration.isPressed ? 0.8 : 1.0)
				// make the button a bit smaller when pressed
				.scaleEffect(configuration.isPressed ? 0.98 : 1.0)
		}
	}
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
				.background(isEnabled ? Color("button_background") : Color.clear)
				.overlay(RoundedRectangle(cornerRadius: 100).stroke(!isEnabled ? Color("textfield_focus_border") : Color.clear, lineWidth: 2))
				.cornerRadius(100)
				.shadow(radius: isEnabled ? 2 : 0, x: 0, y: isEnabled ? 2 : 0)
				// make the button a bit more translucent when pressed
				.opacity(configuration.isPressed ? 0.8 : 1.0)
				// make the button a bit smaller when pressed
				.scaleEffect(configuration.isPressed ? 0.98 : 1.0)
		}
	}
}
