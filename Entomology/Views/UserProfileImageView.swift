//
//  UserProfileImageView.swift
//  Entomology
//
//  Created by Paul Pacheco on 31/05/23.
//

import SwiftUI

struct UserProfileImageView: View {
	@State private var photoSource: PhotoSource?
	@State private var showPhotoOptions = false
	@Binding var imageProfile: UIImage

	var body: some View {
		VStack(spacing: 86) {
			VStack {
				CircleImagePicker(showPhotoOptions: $showPhotoOptions, imageProfile: $imageProfile)
			}.padding(.top, 158)
			MaterialButton(text: "Subir foto de perfil", action: { showPhotoOptions.toggle() })
			Spacer()
		}.backgroundColor(Color("background"))
	}
}

struct UserProfileImageView_Previews: PreviewProvider {
	@State var showOptions = false
	static var previews: some View {
		UserProfileImageView(imageProfile: .constant(UIImage(named: "newphoto")!))
	}
}
