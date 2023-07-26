//
//  ImagePicker.swift
//  Entomology
//
//  Created by Paul Pacheco on 31/05/23.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
	var sourceType: UIImagePickerController.SourceType = .photoLibrary
	
	@Binding var selectedImage: UIImage
	@Environment(\.dismiss) private var dismiss
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
		let imagePicker = UIImagePickerController()
		imagePicker.allowsEditing = false
		imagePicker.sourceType = sourceType
		imagePicker.delegate = context.coordinator
		return imagePicker
	}
	
	func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(parent: self)
	}
	
	final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
		var parent: ImagePicker
		
		init(parent: ImagePicker) {
			self.parent = parent
		}
		
		func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
			if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
				parent.selectedImage = image
			}
			parent.dismiss()
		}
	}
}
