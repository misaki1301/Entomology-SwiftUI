//
//  MaterialFabButton.swift
//  Entomology
//
//  Created by Paul Pacheco on 6/06/23.
//

import SwiftUI

struct MaterialFabButton: View {
	var action: () -> Void
	var icon: String
	var color: String = "background"
	var body: some View {
		Button(action: action) {
			Image(systemName: "\(icon)")
				.frame(width: 24, height: 24)
		}.buttonStyle(MaterialFabButtonStyle(color: color))
	}
}

struct MaterialFabButton_Previews: PreviewProvider {
	static var previews: some View {
		MaterialFabButton(action: {}, icon: "plus")
	}
}
