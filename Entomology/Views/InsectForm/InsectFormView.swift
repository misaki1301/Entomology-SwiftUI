//
//  InsectFormView.swift
//  Entomology
//
//  Created by Paul Pacheco on 8/06/23.
//

import SwiftUI

struct InsectFormView: View {
	@EnvironmentObject var viewRouter: ViewRouter
	
	@State private var showSheetCreateInsect = false
	@State private var showOptions = false
	@State private var image = UIImage(named: "ant")!
	@State private var name = ""
	@State private var url = ""
	@State private var isEditingName = false
	@State private var isEditingUrl = false
	@State private var goToNext = false
	@State private var selectedInsect: Insect?
	@State private var newInsect: Insect?
	
	var body: some View {
		VStack {
			Spacer()
			if let newInsect = newInsect {
				Image(uiImage: UIImage(data: newInsect.localePhoto!)!)
					.resizable()
					.scaledToFill()
					.clipShape(Circle())
					.frame(width: 120, height: 120)
			} else if let selectedInsect = selectedInsect {
				Image(uiImage: UIImage(data: selectedInsect.localePhoto!)!)
					.resizable()
					.scaledToFill()
					.clipShape(Circle())
					.frame(width: 120, height: 120)
			} else {
				Image(uiImage: image)
					.resizable()
					.scaledToFill()
					.clipShape(Circle())
					.frame(width: 120, height: 120)
			}
			VStack(alignment: .leading, spacing: 16) {
				Text("Nombre")
					.padding(.leading, 34)
					.foregroundColor(Color("font_label_primary"))
				TextAutoComplete(text: $name, selected: $selectedInsect, showSheet: $showSheetCreateInsect, isFocused: $isEditingName)
					.accessibilityIdentifier("text_autocomplete_insects")
					.zIndex(100)
				Text("Información adicional")
					.padding(.leading, 34)
					.foregroundColor(Color("font_label_primary"))
					.zIndex(0)
				TextField("URL", text: $url, onEditingChanged: { isEditingUrl = $0 })
					.textFieldStyle(MaterialTextFieldStyle(isEditing: isEditingUrl))
					.zIndex(0)
			}
			.accessibilityIdentifier("textfield_holder_insect")
			Spacer()
			NavigationLink(destination: InsectCountRecordView(insect: (newInsect ?? selectedInsect)), isActive: $goToNext) {
				MaterialButton(id: "select_insect_button", text: "Seleccionar", action: { goToNext.toggle() })
			}
			.isDetailLink(false)
			.disabled(name.isEmpty)
		}
		.sheet(isPresented: $showSheetCreateInsect) {
			CreateInsectView(newInsect: $newInsect)
		}
		.onChange(of: selectedInsect, perform: { newValue in
			url = newValue?.moreInfoUrl ?? ""
		})
		.onChange(of: newInsect, perform: { newValue in
			url = newValue?.moreInfoUrl ?? ""
		})
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
