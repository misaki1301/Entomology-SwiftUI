//
//  CreateInsectView.swift
//  Entomology
//
//  Created by Paul Pacheco on 18/07/23.
//

import SwiftUI

struct CreateInsectView: View {
	internal let inspection = Inspection<Self>()
	
	@Environment(\.dismiss) var dismiss
	
	@Binding var newInsect: Insect?
	
	@State var image: UIImage = UIImage(named: "ant")!
	@State var url: String = ""
	@State var name: String = ""
	@State private var isEditing = false
	@State private var showPhotoOptions = false
	var body: some View {
		VStack {
			Spacer()
			CircleImagePicker(showPhotoOptions: $showPhotoOptions, imageProfile: $image, isClickable: true)
			VStack(alignment: .leading) {
				Text("Nombre especie")
				TextField("Nombre", text: $name)
					.accessibilityIdentifier("textfield_insect_name")
					.textFieldStyle(MaterialTextFieldStyle(isEditing: isEditing))
			}
			VStack(alignment: .leading) {
				Text("Información adicional")
				TextField("URL", text: $url)
					.accessibilityIdentifier("textfield_insect_url")
					.textFieldStyle(MaterialTextFieldStyle(isEditing: isEditing))
			}
			Spacer()
			MaterialButton(text: "Seleccionar") {
				newInsect = Insect(context: CoreDataProvider.currentContext)
				newInsect?.localePhoto = image.pngData()
				newInsect?.moreInfoUrl = url
				newInsect?.speciesName = name
				dismiss()
			}
		}.padding(42)
			.onReceive(inspection.notice) {
				self.inspection.visit(self, $0)
			}
		.backgroundColor(Color("background"))
	}
}

struct CreateInsectView_Previews: PreviewProvider {
	static var previews: some View {
		let insect = Insect(context: CoreDataProvider.preview.viewContext)
		NavigationView {
			CreateInsectView(newInsect: .constant(insect))
		}
	}
}
