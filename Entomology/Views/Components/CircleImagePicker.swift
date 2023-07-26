//
//  CircleImagePicker.swift
//  Entomology
//
//  Created by Paul Pacheco on 18/07/23.
//

import SwiftUI

struct CircleImagePicker: View {
	@State private var photoSource: PhotoSource?
	@Binding var showPhotoOptions: Bool
	@Binding var imageProfile: UIImage
	@State var isClickable: Bool = false
	var body: some View {
		ZStack {
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

struct CircleImagePicker_Previews: PreviewProvider {
    static var previews: some View {
		CircleImagePicker(showPhotoOptions: .constant(false), imageProfile: .constant(UIImage(named: "ant")!), isClickable: true)
    }
}
