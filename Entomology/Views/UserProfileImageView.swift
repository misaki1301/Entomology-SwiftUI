//
//  UserProfileImageView.swift
//  Entomology
//
//  Created by Paul Pacheco on 31/05/23.
//

import SwiftUI

enum PhotoSource: Identifiable {
	
	case photoLibrary
	case camera
	
	var id: Int {
		hashValue
	}
}

struct UserProfileImageView: View {
	
	@State private var photoSource: PhotoSource?
	@State private var showPhotoOptions = false
	@Binding var imageProfile: UIImage
	
    var body: some View {
		VStack(spacing: 86) {
			VStack {
				Image(uiImage: imageProfile)
					.resizable()
					.clipShape(Circle())
					.frame(width: 120, height: 120)
			}.padding(.top, 158)
			Button(action: {showPhotoOptions.toggle()}) {
				Text("Subir foto de perfil")
					.padding(.horizontal, 24)
					.padding(.vertical, 10)
			}
			.buttonStyle(MaterialButtonStyle())
			Spacer()
		}.backgroundColor(Color("background"))
			.confirmationDialog("Escoge la fuente de la imagen", isPresented: $showPhotoOptions, actions: {
				Button(action: {self.photoSource = .camera}) {
					Text("Camara")
				}
				Button(action: {self.photoSource = .photoLibrary}) {
					Text("Galeria de fotos")
				}
			})
			.fullScreenCover(item: $photoSource) { source in
				switch source {
					case .photoLibrary:
						ImagePicker(sourceType: .photoLibrary, selectedImage: $imageProfile).ignoresSafeArea()
					case .camera:
						ImagePicker(sourceType: .camera, selectedImage: $imageProfile).ignoresSafeArea()
				}
			}
    }
}

struct UserProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
		UserProfileImageView(imageProfile: .constant(UIImage(named: "newphoto")!))
    }
}
