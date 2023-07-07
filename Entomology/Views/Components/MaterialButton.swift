//
//  MaterialButton.swift
//  Entomology
//
//  Created by Paul Pacheco on 6/06/23.
//

import SwiftUI

struct MaterialButton: View {
	var id = ""
	var text: String
	var action: () -> Void
	var body: some View {
		Button(action: action) {
			Text(text)
				.padding(.vertical, 10)
				.padding(.horizontal, 24)
		}
		.buttonStyle(MaterialButtonStyle())
		.accessibilityIdentifier(id)
	}
}

struct MaterialButton_Previews: PreviewProvider {
    static var previews: some View {
		return MaterialButton(
			text: "Registro",
			action: {}
		)
    }
}
