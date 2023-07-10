//
//  UserProfileImageView.swift
//  Entomology
//
//  Created by Paul Pacheco on 31/05/23.
//

import SwiftUI

struct CircleImagePickerView: View {
	@State private var photoSource: PhotoSource?
	@Binding var showPhotoOptions: Bool
	@Binding var imageProfile: UIImage
	@State var isClickable: Bool = false
	var body: some View {
		ZStack {
			// Text("\(showPhotoOptions.description)")
			if isClickable {
				Image(uiImage: imageProfile)
					.resizable()
					.scaledToFill()
					.clipShape(Circle())
					.frame(width: 120, height: 120)
					.onTapGesture {
						showPhotoOptions.toggle()
					}
			} else {
				Image(uiImage: imageProfile)
					.resizable()
					.scaledToFill()
					.clipShape(Circle())
					.frame(width: 120, height: 120)
			}
		}
		.confirmationDialog("Escoge la fuente de la imagen", isPresented: $showPhotoOptions, actions: {
			Button(action: { self.photoSource = .camera }) {
				Text("Camara")
			}
			Button(action: { self.photoSource = .photoLibrary }) {
				Text("Galeria de fotos")
			}
		})
		.sheet(item: $photoSource) { source in
			selectSource(for: source)
		}
	}

	private func selectSource(for source: PhotoSource) -> some View {
		switch source {
			case .photoLibrary:
				return ImagePicker(sourceType: .photoLibrary, selectedImage: $imageProfile).ignoresSafeArea()
			case .camera:
				return ImagePicker(sourceType: .camera, selectedImage: $imageProfile).ignoresSafeArea()
		}
	}
}

struct UserProfileImageView: View {
	@State private var photoSource: PhotoSource?
	@State private var showPhotoOptions = false
	@Binding var imageProfile: UIImage

	var body: some View {
		VStack(spacing: 86) {
			VStack {
				CircleImagePickerView(showPhotoOptions: $showPhotoOptions, imageProfile: $imageProfile)
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
		CircleImagePickerView(showPhotoOptions: .constant(false), imageProfile: .constant(UIImage(named: "ant")!), isClickable: true)
	}
}
