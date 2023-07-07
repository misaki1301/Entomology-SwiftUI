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
	@State private var name = "hormiga"
	@State private var url = ""
	@State private var isEditingName = false
	@State private var isEditingUrl = false
	@State private var goToNext = false
    var body: some View {
		VStack {
			Spacer()
			CircleImagePickerView(showPhotoOptions: $showOptions, imageProfile: $image, isClickable: true)
			VStack(alignment: .leading) {
				Text("Nombre").padding(.leading, 34)
				TextField("Nombre especie", text: $name, onEditingChanged: { isEditingName = $0 })
					.textFieldStyle(MaterialTextFieldStyle(isEditing: isEditingName))
			}
			VStack(alignment: .leading) {
				Text("Información adicional").padding(.leading, 34)
				TextField("URL", text: $url, onEditingChanged: { isEditingUrl = $0 })
					.textFieldStyle(MaterialTextFieldStyle(isEditing: isEditingUrl))
			}
			Spacer()
			NavigationLink(destination: InsectCountRecordView(name: name, image: image, url: url), isActive: $goToNext, label: {
				MaterialButton(id: "select_insect_button", text: "Seleccionar", action: {goToNext.toggle()})
			})
				.isDetailLink(false)
			Spacer()
		}
		.accessibilityIdentifier("InsectFormView")
		.padding(42)
		.backgroundColor(Color("background"))
    }
}

struct InsectFormView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView() {
			InsectFormView()
				.environmentObject(ViewRouter())
		}
    }
}
