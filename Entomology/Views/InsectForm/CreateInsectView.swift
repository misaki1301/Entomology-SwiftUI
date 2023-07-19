//
//  CreateInsectView.swift
//  Entomology
//
//  Created by Paul Pacheco on 18/07/23.
//

import SwiftUI

struct CreateInsectView: View {
	@State private var image: UIImage = UIImage(named: "ant")!
	@State private var url: String = ""
	@State private var name: String = ""
	@State private var isEditing = false
	@State private var showPhotoOptions = false
	var body: some View {
		VStack {
			CircleImagePicker(showPhotoOptions: $showPhotoOptions, imageProfile: $image, isClickable: true)
			VStack(alignment: .leading) {
				Text("Nombre especie")
				TextField("Nombre", text: $name)
					.textFieldStyle(MaterialTextFieldStyle(isEditing: isEditing))
			}
			VStack(alignment: .leading) {
				Text("Nombre especie")
				TextField("URL", text: $name)
					.textFieldStyle(MaterialTextFieldStyle(isEditing: isEditing))
			}
		}.backgroundColor(Color("background"))
	}
}

struct CreateInsectView_Previews: PreviewProvider {
	static var previews: some View {
		CreateInsectView()
	}
}
