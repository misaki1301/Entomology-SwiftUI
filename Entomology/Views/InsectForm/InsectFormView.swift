//
//  InsectFormView.swift
//  Entomology
//
//  Created by Paul Pacheco on 8/06/23.
//

import SwiftUI

struct InsectFormView: View {
	@EnvironmentObject var viewRouter: ViewRouter
	@State private var showOptions = false
	@State private var image = UIImage(named: "ant")!
	@State private var name = ""
	@State private var url = ""
	@State private var isEditingName = false
	@State private var isEditingUrl = false
	@State private var goToNext = false
	@State private var selectedInsect: Insect?
	var body: some View {
		VStack {
			Spacer()
			//CircleImagePicker(showPhotoOptions: $showOptions, imageProfile: $image, isClickable: true)
			Image(uiImage: image)
			VStack(alignment: .leading) {
				Text("Nombre")
					.padding(.leading, 34)
					.foregroundColor(Color("font_label_primary"))
				TextAutoCompleteView(text: $name, selected: $selectedInsect)
					.overlay {
						Rectangle().stroke(Color.red)
					}
					.zIndex(200)
				Text("Información adicional")
					.padding(.leading, 34)
					.foregroundColor(Color("font_label_primary"))
					.zIndex(-200)
				TextField("URL", text: $url, onEditingChanged: { isEditingUrl = $0 })
					.textFieldStyle(MaterialTextFieldStyle(isEditing: isEditingUrl))
			}
			Spacer()
			NavigationLink(destination: InsectCountRecordView(name: name, image: image, url: url), isActive: $goToNext, label: {
				MaterialButton(id: "select_insect_button", text: "Seleccionar", action: { goToNext.toggle() })
			})
			.isDetailLink(false)
			.disabled(name.isEmpty)
			Spacer()
		}
		.accessibilityIdentifier("InsectFormView")
		.frame(maxHeight: .infinity)
		.padding(42)
		.backgroundColor(Color("background"))
	}
}

struct InsectFormView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			InsectFormView()
				.environmentObject(ViewRouter())
				.environment(\.managedObjectContext, CoreDataProvider.preview.persistentContainer.viewContext)
		}
	}
}
